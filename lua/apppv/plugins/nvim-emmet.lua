-- https://github.com/olrtg/emmet-language-server
return {
  'olrtg/nvim-emmet',
  event = 'InsertEnter',
  config = function()
    vim.keymap.set({ 'n', 'v' }, '<leader>em', require('nvim-emmet').wrap_with_abbreviation)
  end,
}
