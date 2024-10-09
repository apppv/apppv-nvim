-- https://neovimcraft.com/plugin/danymat/neogen/
return {
  'danymat/neogen',
  enabled = true,
  cmd = 'Neogen',
  keys = { '<localleader>a' },
  config = function()
    vim.keymap.set('n', '<localleader>a', ':Neogen<CR>')
    require('neogen').setup({
      snippet_engine = 'luasnip',
      languages = {
        javascript = {
          template = {
            annotation_convention = 'jsdoc',
          },
        },
        javascriptreact = {
          template = {
            annotation_convention = 'jsdoc',
          },
        },
        python = {
          template = {
            annotation_convention = 'google_docstrings',
          },
        },
        bash = {
          template = {
            annotation_convention = 'google_bash',
          },
        },
        go = {
          template = {
            annotation_convention = 'godoc',
          },
        },
      },
    })
  end,
}
