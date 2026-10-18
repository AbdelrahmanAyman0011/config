-- Gemini completions in the nvim-cmp popup (as a [Gemini] entry next to LSP items).
-- Auto: after you pause typing, one request is made and its result is added to the popup.
-- Manual: <C-g> asks right away.
-- Needs an API key from https://aistudio.google.com/apikey in $GEMINI_API_KEY
-- (a Google AI Plus subscription does not include API access).
local M = {}

local MODEL = vim.env.GEMINI_MODEL or "gemini-flash-lite-latest"
local URL = "https://generativelanguage.googleapis.com/v1beta/models/" .. MODEL .. ":generateContent"
local BEFORE, AFTER = 80, 30
local DEBOUNCE_MS = 700 -- idle time after typing before auto-requesting
local MIN_CHARS = 3 -- non-blank characters before the cursor on the line
local AUTO = true -- set false (or run :GeminiToggle) to only use <C-g>

-- $GEMINI_API_KEY, or (GUI launches skip ~/.zshrc) ask an interactive zsh once.
local cached_key
local function api_key()
  if vim.env.GEMINI_API_KEY and vim.env.GEMINI_API_KEY ~= "" then
    return vim.env.GEMINI_API_KEY
  end
  if cached_key == nil then
    local out = vim.system({ "zsh", "-ic", "printf '<<<%s>>>' \"$GEMINI_API_KEY\"" }, { text = true }):wait(5000)
    cached_key = (out.stdout or ""):match("<<<(%S+)>>>") or ""
  end
  return cached_key ~= "" and cached_key or nil
end

local function clean(text)
  return (text:gsub("^```[%w_+-]*\n", ""):gsub("\n?```%s*$", ""))
end

local job, timer
local cache -- { buf, row, before, text } for the last suggestion

local function cancel()
  if job then pcall(function() job:kill(15) end) job = nil end
  if timer then timer:stop() timer:close() timer = nil end
end

local function cursor_state()
  local buf = vim.api.nvim_get_current_buf()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  return buf, row, col, line:sub(1, col)
end

-- Ask Gemini for the text to insert at the cursor; on success calls done(text).
local function request(done)
  local key = api_key()
  if not key then return end
  local buf, row, col, before_line = cursor_state()
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  local before = {}
  for i = math.max(1, row - BEFORE), row - 1 do before[#before + 1] = lines[i] end
  before[#before + 1] = before_line
  local after = { (lines[row] or ""):sub(col + 1) }
  for i = row + 1, math.min(#lines, row + AFTER) do after[#after + 1] = lines[i] end

  local body = vim.json.encode({
    systemInstruction = { parts = { { text = "You are a code completion engine. Reply with ONLY the code that belongs at the cursor, no explanation and no markdown fences. Keep it short: finish the current statement or block." } } },
    contents = { { role = "user", parts = { { text = string.format(
      "Language: %s\n<before>\n%s</before>\n<after>\n%s</after>\nWrite the text to insert between them.",
      vim.bo[buf].filetype, table.concat(before, "\n"), table.concat(after, "\n")) } } } },
    generationConfig = { temperature = 0.2, maxOutputTokens = 256 },
  })
  local file = vim.fn.tempname()
  vim.fn.writefile({ body }, file)

  local this
  this = vim.system(
    { "curl", "-sS", "--max-time", "15", "-K", "-", "-H", "Content-Type: application/json", "--data-binary", "@" .. file,
      URL },
    { text = true, stdin = 'header = "x-goog-api-key: ' .. key .. '"\n' },
    vim.schedule_wrap(function(res)
      os.remove(file)
      if job == this then job = nil end
      if res.signal ~= 0 then return end -- cancelled by a newer request
      if res.code ~= 0 then
        return vim.notify("Gemini: request failed: " .. vim.trim(res.stderr or ""), vim.log.levels.WARN)
      end
      local ok, data = pcall(vim.json.decode, res.stdout)
      if not ok then
        return vim.notify("Gemini: bad response: " .. (res.stdout or ""):sub(1, 200), vim.log.levels.WARN)
      end
      if data.error then
        return vim.notify("Gemini: " .. (data.error.message or "request failed"), vim.log.levels.WARN)
      end
      local part = data.candidates and data.candidates[1] and data.candidates[1].content
        and data.candidates[1].content.parts and data.candidates[1].content.parts[1]
      if not part or not part.text or part.text == "" then return end
      -- only use it if the cursor is still where we asked
      local b2, r2, _, bl2 = cursor_state()
      if b2 ~= buf or r2 ~= row or bl2 ~= before_line or not vim.api.nvim_get_mode().mode:find("^i") then return end
      done({ buf = buf, row = row, before = before_line, text = clean(part.text) })
    end)
  )
  job = this
end

local source = {}

function source.new()
  return setmetatable({}, { __index = source })
end

function source:is_available()
  return api_key() ~= nil
end

function source:get_debug_name()
  return "gemini"
end

-- No network here: just hand cmp the suggestion fetched for this exact cursor position.
function source:complete(params, callback)
  local buf = params.context.bufnr
  local row = params.context.cursor.row
  local before = params.context.cursor_before_line
  if not cache or cache.buf ~= buf or cache.row ~= row or cache.before ~= before then
    return callback()
  end
  -- cmp replaces the word being typed with insertText and filters items against it, so
  -- prefix the suggestion with that word (it is inserted right after it, so the result is identical).
  local prefix = vim.fn.matchstr(before, [[\k*$]])
  local text = prefix .. cache.text
  callback({
    items = { {
      label = vim.split(text, "\n")[1],
      insertText = text,
      kind = vim.lsp.protocol.CompletionItemKind.Text,
      documentation = { kind = "markdown", value = "```" .. vim.bo[buf].filetype .. "\n" .. text .. "\n```" },
    } },
    isIncomplete = false,
  })
end

function M.setup(cmp)
  cmp.register_source("gemini", source.new())

  local function fetch_and_show()
    request(function(result)
      cache = result
      cmp.complete() -- reopen the popup with every source, now including Gemini
    end)
  end

  vim.api.nvim_create_autocmd({ "TextChangedI", "TextChangedP" }, {
    group = vim.api.nvim_create_augroup("GeminiAutoComplete", { clear = true }),
    callback = function()
      cancel()
      if not AUTO or not api_key() then return end
      local _, _, _, before = cursor_state()
      if #before:gsub("%s", "") < MIN_CHARS then return end
      timer = vim.uv.new_timer()
      local this = timer
      this:start(DEBOUNCE_MS, 0, vim.schedule_wrap(function()
        if timer == this then
          this:close()
          timer = nil
          fetch_and_show()
        end
      end))
    end,
  })
  vim.api.nvim_create_autocmd({ "InsertLeave", "BufLeave" }, { callback = cancel })

  vim.keymap.set("i", "<C-g>", function()
    if not api_key() then
      return vim.notify("Gemini: set GEMINI_API_KEY (https://aistudio.google.com/apikey)", vim.log.levels.WARN)
    end
    cancel()
    fetch_and_show()
  end, { desc = "Gemini completion" })

  vim.api.nvim_create_user_command("GeminiToggle", function()
    AUTO = not AUTO
    cancel()
    vim.notify("Gemini auto-complete " .. (AUTO and "on" or "off"))
  end, {})
end

return M
