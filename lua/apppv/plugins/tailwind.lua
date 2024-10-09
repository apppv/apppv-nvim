return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        tailwindcss = {},
      },
    },
  },

  {
    'MaximilianLloyd/tw-values.nvim',
    keys = {
      { '<leader>tw', '<cmd>TWValues<cr>', desc = 'Show tailwind CSS values' },
    },
    opts = {
      border = 'rounded', -- Valid window border style,
      show_unknown_classes = true, -- Shows the unknown classes popup
      focus_preview = true, -- Sets the preview as the current window
      copy_register = '', -- The register to copy values to,
      keymaps = {
        copy = '<C-y>', -- Normal mode keymap to copy the CSS values between {}
      },
    },
  },

  {
    'princejoogie/tailwind-highlight.nvim',
    event = 'BufReadPre',
    config = function()
      require('lspconfig').tailwindcss.setup({
        on_attach = function(client, bufnr)
          -- rest of you config
          local tw_highlight = require('tailwind-highlight')
          tw_highlight.setup(client, bufnr, {
            single_column = false,
            mode = 'background',
            debounce = 200,
          })
        end,
      })
    end,
  },
}

