-- claude-context.lua
-- Shows the previous Claude Code assistant response in a top split
-- when Neovim is opened as $EDITOR via <C-g> in Claude Code.
--
-- No wrapper script or Claude Code configuration required.
-- Claude Code creates temp files matching: claude-prompt-<UUID>.md
--
-- Usage:
--   In init.lua: require("claude-context").setup()

local M = {}

-- ~/.claude/projects/ encodes the cwd by replacing every '/' and '.' with '-'
local function encode_cwd(cwd)
  return (cwd:gsub("[/.]", "-"))
end

-- Walk up the process tree from `pid` and return the first ancestor PID
-- that has a corresponding ~/.claude/sessions/<pid>.json file.
-- Returns the parsed session object, or nil if not found.
local function find_claude_session_by_process_tree()
  local sessions_dir = vim.fn.expand("~") .. "/.claude/sessions"
  if vim.fn.isdirectory(sessions_dir) == 0 then
    return nil
  end

  local pid = vim.fn.getpid()
  for _ = 1, 10 do
    local ppid_str = vim.fn.system("ps -o ppid= -p " .. pid)
    local ppid = tonumber(ppid_str:match("%d+"))
    if not ppid or ppid <= 1 then
      break
    end

    local session_file = sessions_dir .. "/" .. ppid .. ".json"
    if vim.fn.filereadable(session_file) == 1 then
      local fh = io.open(session_file, "r")
      if fh then
        local content = fh:read("*a")
        fh:close()
        local ok, obj = pcall(vim.fn.json_decode, content)
        if ok and type(obj) == "table" and obj.sessionId then
          return obj
        end
      end
    end

    pid = ppid
  end

  return nil
end

-- Resolve the JSONL path for the given session and cwd.
-- Falls back to the most recently modified JSONL if the session file is not found.
local function find_jsonl(cwd)
  local encoded = encode_cwd(cwd)
  local dir = vim.fn.expand("~") .. "/.claude/projects/" .. encoded
  if vim.fn.isdirectory(dir) == 0 then
    return nil
  end

  -- Primary: match session ID to the process tree
  local session = find_claude_session_by_process_tree()
  if session then
    local jsonl = dir .. "/" .. session.sessionId .. ".jsonl"
    if vim.fn.filereadable(jsonl) == 1 then
      return jsonl
    end
  end

  -- Fallback: most recently modified JSONL (single-session case)
  local files = vim.fn.glob(dir .. "/*.jsonl", false, true)
  if #files == 0 then
    return nil
  end
  table.sort(files, function(a, b)
    return vim.fn.getftime(a) > vim.fn.getftime(b)
  end)
  return files[1]
end

-- Parse the JSONL and return the last assistant text block
local function extract_last_assistant_text(jsonl_path)
  local fh = io.open(jsonl_path, "r")
  if not fh then
    return nil
  end
  local last = nil
  for line in fh:lines() do
    local ok, obj = pcall(vim.fn.json_decode, line)
    if ok and type(obj) == "table" and obj.type == "assistant" then
      local content = (obj.message or {}).content
      if type(content) == "table" then
        for _, block in ipairs(content) do
          if type(block) == "table" and block.type == "text" and block.text then
            last = block.text
          end
        end
      elseif type(content) == "string" and content ~= "" then
        last = content
      end
    end
  end
  fh:close()
  return last
end

-- Open a read-only markdown split on the top showing the given text.
-- When the prompt buffer is closed, automatically quit nvim so the user
-- returns to Claude Code immediately without closing the split manually.
local function open_context_split(text)
  local lines = vim.split(text, "\n", { plain = true })
  local response_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(response_buf, 0, -1, false, lines)
  vim.bo[response_buf].filetype = "markdown"
  vim.bo[response_buf].modifiable = false
  vim.bo[response_buf].buftype = "nofile"
  vim.bo[response_buf].swapfile = false
  vim.api.nvim_buf_set_name(response_buf, "[Claude Response]")

  local height = math.max(10, math.floor(vim.o.lines * 0.4))
  vim.cmd("topleft split")
  local response_win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(response_win, response_buf)
  vim.api.nvim_win_set_height(response_win, height)
  -- Move cursor to the prompt buffer (bottom pane)
  vim.cmd("wincmd j")

  -- When the prompt window is closed (e.g. :wq), force-quit nvim so the
  -- user returns to Claude Code without having to close the response split.
  -- BufUnload fires too late (when the buffer is evicted from memory, not
  -- when the window closes), so WinClosed is the right event here.
  local prompt_win = vim.api.nvim_get_current_win()
  vim.api.nvim_create_autocmd("WinClosed", {
    pattern = tostring(prompt_win),
    once = true,
    callback = function()
      vim.schedule(function()
        vim.cmd("qa!")
      end)
    end,
  })
end

function M.setup()
  -- Use VimEnter instead of BufReadPost:
  -- BufReadPost can be consumed by lazy.nvim's lazy-loading mechanism.
  -- By VimEnter, the initial buffer is already set up and we can safely
  -- inspect it without competing with lazy.nvim's event hooks.
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      local fname = vim.api.nvim_buf_get_name(0)
      -- Detect Claude Code's temp prompt file (claude-prompt-<UUID>.md)
      if not fname:match("claude%-prompt%-[0-9a-f%-]+%.md$") then
        return
      end

      local cwd = vim.fn.getcwd()
      local jsonl = find_jsonl(cwd)
      if not jsonl then
        return
      end

      vim.defer_fn(function()
        local text = extract_last_assistant_text(jsonl)
        if text then
          open_context_split(text)
        end
      end, 50)
    end,
  })
end

return M
