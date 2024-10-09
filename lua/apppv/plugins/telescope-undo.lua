return {
  'debugloop/telescope-undo.nvim',
  dependencies = { -- note how they're inverted to above example
    {
      'nvim-telescope/telescope.nvim',
      dependencies = { 'nvim-lua/plenary.nvim' },
    },
  },
  keys = {
    { -- lazy style key map
      '<leader>ut',
      '<cmd>Telescope undo<cr>',
      desc = 'undo telescope',
    },
  },
  opts = {
    -- don't use `defaults = { }` here, do this in the main telescope spec
    extensions = {
      undo = {
        mappings = {
          i = {
            ['<cr>'] = function(bufnr)
              return require('telescope-undo.actions').restore(bufnr)
            end,
          },
          n = {
            ['u'] = function(bufnr)
              return require('telescope-undo.actions').restore(bufnr)
            end,
          },
        },
      },
    },
  },
  config = function(_, opts)
    -- Calling telescope's setup from multiple specs does not hurt, it will happily merge the
    -- configs for us. We won't use data, as everything is in it's own namespace (telescope
    -- defaults, as well as each extension).
    require('telescope').setup(opts)
    require('telescope').load_extension('undo')
  end,
}
