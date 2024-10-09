return {
  {
    'pmizio/typescript-tools.nvim',
    event = 'BufReadPre',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    ft = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'typescript.tsx' },
    opts = {},
    config = function()
      require('typescript-tools').setup({
        settings = {
          separate_diagnostic_server = true,
          expose_as_code_action = 'all',
          tsserver_max_memory = 'auto',
          complete_function_calls = true,
          include_completions_with_insert_text = true,
          tsserver_file_preferences = {
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayVariableTypeHintsWhenTypeMatchesName = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
            includeCompletionsForModuleExports = true,
            quotePreference = 'single',
          },
          tsserver_format_options = {
            allowIncompleteCompletions = false,
            allowRenameOfImportPath = false,
          },
        },
      })
    end,
  },
  {
    'dmmulroy/ts-error-translator.nvim',
    enabled = true,
    ft = { 'typescript', 'typescriptreact' },
    config = function()
      require('ts-error-translator').setup({})
    end,
  },
  {
    'dmmulroy/tsc.nvim',
    enabled = true,
    ft = { 'typescript', 'typescriptreact' },
    event = 'VeryLazy',
    cmd = 'TSC',
    keys = {
      { '<leader>tc', '<cmd>TSC<cr>', desc = '[T]ype [C]heck' },
    },
    config = function()
      require('tsc').setup({ enable_progress_notifications = true })
    end,
  },
}
