-- Build and run Go packages.
local M = {}

local run_win

local function current_source()
  local src = vim.api.nvim_buf_get_name(0)
  if src == '' then
    vim.notify('Go: save the file first', vim.log.levels.WARN)
    return nil
  end
  if vim.bo.filetype ~= 'go' then
    vim.notify('Go: current buffer is not a Go file', vim.log.levels.WARN)
    return nil
  end
  return src
end

local function is_main(src)
  local f = io.open(src, 'r')
  if not f then
    return false
  end
  for line in f:lines() do
    if line:match('^%s*package%s+main%s*$') then
      f:close()
      return true
    end
    -- stop scanning after first non-comment/blank? Keep simple: any package main.
  end
  f:close()
  return false
end

local function shell_command(cmd)
  return table.concat(vim.tbl_map(vim.fn.shellescape, cmd), ' ')
end

local function save()
  local ok, err = pcall(vim.cmd, 'write')
  if not ok then
    vim.notify('Go: could not write file: ' .. err, vim.log.levels.ERROR)
    return false
  end
  return true
end

local function open_terminal(cmd, cwd)
  local wins = vim.api.nvim_tabpage_list_wins(0)
  if run_win and vim.api.nvim_win_is_valid(run_win) and #wins > 1 then
    vim.api.nvim_win_close(run_win, true)
  end
  vim.cmd 'botright 12new'
  run_win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_get_current_buf()
  vim.bo[buf].bufhidden = 'wipe'
  local job = vim.fn.jobstart({ vim.o.shell, '-c', cmd }, { cwd = cwd, term = true })
  if job <= 0 then
    vim.notify('Go: could not start terminal', vim.log.levels.ERROR)
    if vim.api.nvim_win_is_valid(run_win) then
      vim.api.nvim_win_close(run_win, true)
    end
    run_win = nil
    return
  end
  vim.cmd 'startinsert'
end

function M.build()
  local src = current_source()
  if not src then
    return
  end
  if not save() then
    return
  end
  local dir = vim.fn.fnamemodify(src, ':h')
  local has_mod = vim.fn.filereadable(dir .. '/go.mod') == 1
  local fname = vim.fn.fnamemodify(src, ':t')
  local cmd
  if is_main(src) then
    if has_mod then
      cmd = 'go build -o out .'
    else
      cmd = 'go build -o out ' .. vim.fn.shellescape(fname)
    end
  else
    if has_mod then
      cmd = 'go build .'
    else
      cmd = 'go vet ' .. vim.fn.shellescape(fname)
    end
  end
  open_terminal(cmd, dir)
end

function M.run()
  local src = current_source()
  if not src then
    return
  end
  if not save() then
    return
  end
  if not is_main(src) then
    vim.notify('Go: current package is not `main`, cannot run', vim.log.levels.WARN)
    return
  end
  local dir = vim.fn.fnamemodify(src, ':h')
  local has_mod = vim.fn.filereadable(dir .. '/go.mod') == 1
  local fname = vim.fn.fnamemodify(src, ':t')
  local cmd
  if has_mod then
    cmd = 'go run .'
  else
    cmd = 'go run ' .. vim.fn.shellescape(fname)
  end
  open_terminal(cmd, dir)
end

return M