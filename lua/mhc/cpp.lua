-- Build and run single-file C++ programs.
--
-- Output binary is `out` next to the source file, matching cpp-practice's
-- existing layout and .gitignore.
local M = {}

local args = { 'g++', '-std=c++20', '-g', '-O0', '-Wall', '-Wextra', '-Wpedantic' }

local run_win

local function current_source()
  local src = vim.api.nvim_buf_get_name(0)
  if src == '' then
    vim.notify('C++: save the file first', vim.log.levels.WARN)
    return nil
  end
  if vim.bo.filetype ~= 'cpp' then
    vim.notify('C++: current buffer is not a C++ file', vim.log.levels.WARN)
    return nil
  end
  return src
end

local function has_main(src)
  local f = io.open(src, 'r')
  if not f then return false end
  local text = f:read('*a')
  f:close()
  return text:match('int%s+main%s*%(') ~= nil or text:match('main%s*%(') ~= nil
end

local function binary(src)
  return vim.fn.fnamemodify(src, ':h') .. '/out'
end

local function compile_args(src)
  local cmd = vim.list_extend({}, args)
  vim.list_extend(cmd, { src, '-o', binary(src) })
  return cmd
end

local function shell_command(cmd)
  return table.concat(vim.tbl_map(vim.fn.shellescape, cmd), ' ')
end

local function save()
  local ok, err = pcall(vim.cmd, 'write')
  if not ok then
    vim.notify('C++: could not write file: ' .. err, vim.log.levels.ERROR)
    return false
  end
  return true
end

-- Open a terminal split and run `cmd` through the shell, so `&&`, compiler
-- errors, and interactive stdin all behave like a normal terminal.
local function open_terminal(cmd, cwd)
  local wins = vim.api.nvim_tabpage_list_wins(0)
  if run_win and vim.api.nvim_win_is_valid(run_win) and #wins > 1 then
    vim.api.nvim_win_close(run_win, true)
  end

  -- `new`, not `split`: `split` reuses the source buffer, and the terminal job
  -- would then replace the code in both windows with the terminal.
  vim.cmd 'botright 12new'
  run_win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_get_current_buf()
  vim.bo[buf].bufhidden = 'wipe'

  local job = vim.fn.jobstart({ vim.o.shell, '-c', cmd }, { cwd = cwd, term = true })
  if job <= 0 then
    vim.notify('C++: could not start terminal', vim.log.levels.ERROR)
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
  open_terminal(shell_command(compile_args(src)), vim.fn.fnamemodify(src, ':h'))
end

function M.run()
  local src = current_source()
  if not src then
    return
  end
  if not has_main(src) then
    vim.notify('C++: no main() in file, cannot run', vim.log.levels.WARN)
    return
  end
  if not save() then
    return
  end
  local cmd = shell_command(compile_args(src)) .. ' && ' .. vim.fn.shellescape(binary(src))
  open_terminal(cmd, vim.fn.fnamemodify(src, ':h'))
end

return M
