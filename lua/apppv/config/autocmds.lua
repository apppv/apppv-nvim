--*******************************************************--
--                                                       --
--                          AUTOCMDs                     --
--                                                       --
--*******************************************************--

--    [[ Highlight on yank ]]
--    See `:help vim.highlight.on_yank()`
--    Taken from: https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

--    [[ Disable continuation of comments to the next line ]]
--    vim.cmd([[autocmd BufEnter * set formatoptions-=o]])
--    https://www.reddit.com/r/neovim/comments/1963j83/is_there_a_way_to_disable_comment_continuation/
vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    vim.opt.formatoptions:remove({ 'c', 'r', 'o' })
  end,
  desc = 'Disable New Line Comment',
})
