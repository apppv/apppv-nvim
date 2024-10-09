--[[
    https://www.reddit.com/r/neovim/comments/tge2ty/python_toggle_fstring_using_treesitter/
    Hi Friends, i made this function to toggle f-strings on python.
    It tries to find a string node (in current or parent nodes) in order to make the necessary changes.
--]]
local ts_utils = require('nvim-treesitter.ts_utils')

local toggle_fstring = function()
  local winnr = 0
  local cursor = vim.api.nvim_win_get_cursor(winnr)
  local node = ts_utils.get_node_at_cursor()

  while (node ~= nil) and (node:type() ~= 'string') do
    node = node:parent()
  end
  if node == nil then
    print('f-string: not in string node :(')
    return
  end

  local srow, scol, ecol, erow = ts_utils.get_vim_range({ node:range() })
  vim.fn.setcursorcharpos(srow, scol)
  local char = vim.api.nvim_get_current_line():sub(scol, scol)
  local is_fstring = (char == 'f')

  if is_fstring then
    vim.cmd('normal x')
    -- if cursor is in the same line as text change
    if srow == cursor[1] then
      cursor[2] = cursor[2] - 1 -- negative offset to cursor
    end
  else
    vim.cmd('normal if')
    -- if cursor is in the same line as text change
    if srow == cursor[1] then
      cursor[2] = cursor[2] + 1 -- positive offset to cursor
    end
  end
  vim.api.nvim_win_set_cursor(winnr, cursor)
end

vim.keymap.set('n', '<leader>F', toggle_fstring, { noremap = true })
