-- Lightweight jq integration: format a selection/buffer in place, or open a
-- live floating explorer for poking at JSON with arbitrary jq expressions.
local M = {}

local api = vim.api

-- Run jq synchronously over `input`, returning (ok, output_lines, is_error).
local function run_jq_sync(filter, input)
  local res = vim.system({ "jq", filter }, { stdin = input }, nil):wait()
  local ok = res.code == 0
  local text = (ok and res.stdout or res.stderr or "") or ""
  return ok, text
end

-- :Jq [filter] -- filter the given range (default: whole file) through jq and
-- replace it in place. Leaves the buffer untouched if jq errors.
local function format_range(opts)
  local filter = opts.args ~= "" and opts.args or "."
  local lines = api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, false)
  local ok, text = run_jq_sync(filter, table.concat(lines, "\n"))
  if not ok then
    vim.notify(text, vim.log.levels.ERROR, { title = "jq" })
    return
  end
  local out = vim.split((text:gsub("\n$", "")), "\n")
  api.nvim_buf_set_lines(0, opts.line1 - 1, opts.line2, false, out)
end

-- ---- Live explorer -------------------------------------------------------

local function open_explorer(opts)
  local src_buf = api.nvim_get_current_buf()
  local src_l1, src_l2 = opts.line1, opts.line2
  local input = table.concat(api.nvim_buf_get_lines(0, src_l1 - 1, src_l2, false), "\n")

  local W = math.floor(vim.o.columns * 0.8)
  local H = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - H) / 2)
  local col = math.floor((vim.o.columns - W) / 2)

  -- Output window (top) and filter input (single line, bottom).
  local out_buf = api.nvim_create_buf(false, true)
  local in_buf = api.nvim_create_buf(false, true)
  api.nvim_buf_set_lines(in_buf, 0, -1, false, { "." })

  local out_win = api.nvim_open_win(out_buf, false, {
    relative = "editor", width = W, height = H - 3, row = row, col = col,
    border = "rounded", title = " jq output ", title_pos = "center",
  })
  local in_win = api.nvim_open_win(in_buf, true, {
    relative = "editor", width = W, height = 1, row = row + H - 1, col = col,
    border = "rounded", title = " jq filter ", title_pos = "center",
  })
  api.nvim_set_option_value("filetype", "json", { buf = out_buf })
  api.nvim_set_option_value("wrap", true, { win = out_win })

  -- Track output so <C-y>/<C-a> operate on exactly what's displayed.
  local last_out, last_ok = { input }, true
  local raw, compact = false, false -- jq -r / -c toggles
  local seq, timer = 0, nil

  -- Refresh the output window's title/footer to reflect state + key hints.
  local function chrome()
    if not api.nvim_win_is_valid(out_win) then return end
    local tag = ""
    if raw or compact then
      tag = " [" .. (raw and "-r" or "") .. (raw and compact and " " or "") .. (compact and "-c" or "") .. "]"
    end
    api.nvim_win_set_config(out_win, {
      title = (last_ok and " jq output" or " jq: error") .. tag .. " ", title_pos = "center",
      footer = " <C-r> raw:" .. (raw and "on" or "off")
        .. "  <C-c> compact:" .. (compact and "on" or "off")
        .. "  ·  <C-y> yank  <C-a> apply  <Esc>/q close ",
      footer_pos = "center",
    })
  end

  local function render()
    seq = seq + 1
    local my = seq
    local filter = api.nvim_buf_get_lines(in_buf, 0, -1, false)[1] or "."
    if filter == "" then filter = "." end
    local cmd = { "jq" }
    if raw then cmd[#cmd + 1] = "-r" end
    if compact then cmd[#cmd + 1] = "-c" end
    cmd[#cmd + 1] = filter
    vim.system(cmd, { stdin = input }, function(res)
      if my ~= seq then return end -- a newer keystroke superseded us
      vim.schedule(function()
        if not api.nvim_win_is_valid(out_win) then return end
        last_ok = res.code == 0
        local text = (last_ok and res.stdout or res.stderr or "") or ""
        last_out = vim.split((text:gsub("\n$", "")), "\n")
        api.nvim_set_option_value("modifiable", true, { buf = out_buf })
        api.nvim_buf_set_lines(out_buf, 0, -1, false, last_out)
        api.nvim_set_option_value("modifiable", false, { buf = out_buf })
        -- Raw output isn't valid JSON, so drop json highlighting for it.
        api.nvim_set_option_value("filetype", (last_ok and not raw) and "json" or "text", { buf = out_buf })
        chrome()
      end)
    end)
  end

  -- Debounce keystrokes so we don't spawn a jq per character on big payloads.
  local function schedule_render()
    if timer then timer:stop() end
    timer = vim.defer_fn(render, 40)
  end

  local function close()
    if timer then timer:stop() end
    vim.cmd("stopinsert") -- else insert mode carries into the window we land on
    pcall(api.nvim_win_close, in_win, true)
    pcall(api.nvim_win_close, out_win, true)
  end

  -- Yank but stay open, so you can keep exploring after grabbing a result.
  local function yank()
    vim.fn.setreg("+", table.concat(last_out, "\n"))
    vim.notify("Yanked jq result to clipboard", vim.log.levels.INFO, { title = "jq" })
  end

  local function apply()
    if not last_ok then
      vim.notify("Not applying: jq errored", vim.log.levels.WARN, { title = "jq" })
      return
    end
    if api.nvim_buf_is_valid(src_buf) then
      api.nvim_buf_set_lines(src_buf, src_l1 - 1, src_l2, false, last_out)
    end
    close()
  end

  api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
    buffer = in_buf, callback = schedule_render,
  })

  local function toggle_raw() raw = not raw; chrome(); render() end
  local function toggle_compact() compact = not compact; chrome(); render() end

  local function map(buf, lhs, fn)
    vim.keymap.set({ "n", "i" }, lhs, fn, { buffer = buf, silent = true })
  end
  for _, b in ipairs({ in_buf, out_buf }) do
    map(b, "<C-y>", yank)
    map(b, "<C-a>", apply)
    map(b, "<C-r>", toggle_raw)
    map(b, "<C-c>", toggle_compact)
    -- Close from normal mode only, so <Esc> in insert just returns to normal
    -- mode -- leaving the filter box fully editable with vim bindings.
    vim.keymap.set("n", "<Esc>", close, { buffer = b, silent = true })
    vim.keymap.set("n", "q", close, { buffer = b, silent = true })
  end

  chrome()
  render()
  vim.cmd("startinsert!")
end

function M.setup()
  api.nvim_create_user_command("Jq", format_range, {
    range = "%", nargs = "*", desc = "Filter range through jq (default: .)",
  })
  api.nvim_create_user_command("JqExplore", open_explorer, {
    range = "%", desc = "Open a live jq explorer over the range/buffer",
  })

  -- <leader>jf: format buffer/selection in place.  <leader>jq: live explorer.
  vim.keymap.set("n", "<leader>jf", ":Jq<CR>", { silent = true, desc = "jq format buffer" })
  vim.keymap.set("x", "<leader>jf", ":Jq<CR>", { silent = true, desc = "jq format selection" })
  vim.keymap.set("n", "<leader>jq", ":JqExplore<CR>", { silent = true, desc = "jq explorer (buffer)" })
  vim.keymap.set("x", "<leader>jq", ":JqExplore<CR>", { silent = true, desc = "jq explorer (selection)" })
end

return M
