--                   [[ mappings.lua ]]

--********************************************************--
--                   Neovim Keybindings                   --
--********************************************************--

--[[
LEADER
 These keybindings need to be defined before the first / is called; otherwise, it will default to "\"
 Set <space> as the leader key
 See `:help mapleader`
  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
--]]
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', '<leader>c', ':close<CR>', { desc = 'Close' })

-- Clear search highlights
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlights' })

-- Easy way to get back to normal mode from home row
vim.keymap.set('i', 'kj', '<Esc>') -- kj simulates ESC
vim.keymap.set('i', 'jk', '<Esc>') -- jk simulates ESC

-- map leader+w to save current file in normal mode
vim.keymap.set(
  'n',
  '<Leader>w',
  ':write<CR>',
  { noremap = true, silent = true },
  { desc = 'Write changes to a file in normal mode' }
)

-- Move selection in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Remap for dealing with visual line wraps
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Indent and reselect visual block after indenting
vim.keymap.set('v', '>', [[>gv]], {
  noremap = true,
})
vim.keymap.set('v', '<', [[<gv]], {
  noremap = true,
})

-- Join lines and return cursor to original position
vim.keymap.set('n', 'J', 'mzJ`z')

-- Scroll half a page down and center the cursor
vim.keymap.set('n', '<C-d>', '<C-d>zz')

-- Scroll half a page up and center the cursor
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Move to next search result and center the cursor
vim.keymap.set('n', 'n', 'nzzzv')

-- Move to previous search result and center the cursor
vim.keymap.set('n', 'N', 'Nzzzv')

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
-- [[ Remap 'n' based on search direction in normal, visual, and operator-pending modes ]]
vim.keymap.set('n', 'n', function()
  return vim.v.searchforward == 1 and 'n' or 'N'
end, { expr = true, noremap = true })

vim.keymap.set('x', 'n', function()
  return vim.v.searchforward == 1 and 'n' or 'N'
end, { expr = true, noremap = true })

vim.keymap.set('o', 'n', function()
  return vim.v.searchforward == 1 and 'n' or 'N'
end, { expr = true, noremap = true })

-- Remap 'N' based on search direction in normal, visual, and operator-pending modes
vim.keymap.set('n', 'N', function()
  return vim.v.searchforward == 1 and 'N' or 'n'
end, { expr = true, noremap = true })

vim.keymap.set('x', 'N', function()
  return vim.v.searchforward == 1 and 'N' or 'n'
end, { expr = true, noremap = true })

vim.keymap.set('o', 'N', function()
  return vim.v.searchforward == 1 and 'N' or 'n'
end, { expr = true, noremap = true })

vim.keymap.set({ 'n', 'v' }, 'p', [["+p]], { desc = 'Paste from system clipboard' })
vim.keymap.set({ 'n', 'v' }, 'P', [["+P]], { desc = 'Paste from system clipboard' })
-- delete without copy
vim.keymap.set({ 'n', 'v', 'x' }, 'x', [["_x]])

vim.keymap.set({ 'n', 'v' }, 'y', '"*y', { noremap = true, desc = 'Yank to clipboard' })
vim.keymap.set('n', 'yy', '"*yy', { noremap = true, desc = 'Yank line to clipboard' })

-- default mapping: Y => y$
-- https://github.com/neovim/neovim/pull/13268
vim.keymap.set('n', 'Y', '"*y$', { noremap = true, desc = 'Yank to end of line to clipboard' })
vim.keymap.set('n', 'dd', '"*dd', { noremap = true, desc = 'Cut line to clipboard' })
vim.keymap.set('n', 'D', '"*D', { noremap = true, desc = 'Cut to end of line to clipboard' })

vim.keymap.set('n', '<leader>y', function()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('ggVG"+y', true, false, true), 'n', true)
end, { noremap = true, silent = true, desc = 'Yank whole file to system clipboard' })

-- [[ Splits management ]]
-- Navigate split panes better <C-{h,j,k,l}>
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')
vim.keymap.set('n', '<leader>se', '<C-w>=', { desc = 'Make splits equal size' }) -- make split windows equal width & height
-- <C-w>x switch splits

-- [[ Tabs ]]
vim.keymap.set('n', '<leader>tf', '<cmd>tabnew %<CR>', { desc = 'Open current buffer in new tab' }) --  move current buffer to new tab
vim.keymap.set('n', '<leader>tx', '<cmd>tabclose<CR>', { desc = 'Close current tab' }) -- close current tab
vim.keymap.set('n', '<leader>tq', '<cmd>tabo<CR>', { desc = 'Close all other tabs besides the active one' }) -- close all other tabs

-- [[ Buffers ]]
vim.keymap.set('n', '<leader>bx', ':bd!%<CR>', { desc = 'Close current buffer' })
vim.keymap.set('n', 'bh', ':bprevious<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', 'bl', ':bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', 'bH', ':bfirst<CR>', { desc = 'First buffer' })
vim.keymap.set('n', 'bL', ':blast<CR>', { desc = 'Last buffer' })

vim.keymap.set('n', '[b', ':bprevious<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', ']b', ':bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '[B', ':bfirst<CR>', { desc = 'First buffer' })
vim.keymap.set('n', ']B', ':blast<CR>', { desc = 'Last buffer' })
