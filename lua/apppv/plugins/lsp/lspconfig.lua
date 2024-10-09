return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
  },
  config = function()
    -- import lspconfig plugin
    local lspconfig = require('lspconfig')

    -- import cmp-nvim-lsp plugin
    local cmp_nvim_lsp = require('cmp_nvim_lsp')

    local keymap = vim.keymap -- for conciseness
    local opts = { noremap = true, silent = true }
    local on_attach = function(client, bufnr)
      opts.buffer = bufnr

      -- Hover Documentation: Show documentation for symbol under cursor.
      -- Instantly access function signatures, parameter info, and more. Essential for learning.
      opts.desc = 'Hover Documentation'
      keymap.set('n', 'K', vim.lsp.buf.hover, opts) -- Show documentation for what is under cursor

      -- Goto References: See all places where a symbol is used in your project.
      -- Helps in understanding the impact and usage of variables/functions.
      opts.desc = '[G]oto [R]eferences'
      keymap.set('n', 'gR', '<cmd>Telescope lsp_references<CR>', opts) -- Show definition, references

      -- Goto Definition: Jump to where a symbol is defined.
      -- Useful for exploring libraries or understanding how your code is structured.
      opts.desc = '[G]oto [D]efinition'
      keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts) -- Show LSP definitions

      -- Goto Type Definition: Jump to the definition of the type of the symbol under the cursor.
      -- In TypeScript, this could take you to where a type or interface is defined.
      -- In Go, it might jump to the definition of a struct, interface, or even a basic type.
      -- This feature is invaluable for understanding the structure of the data you're working with,
      -- especially in languages like TypeScript where complex types and interfaces are common.
      -- In Go, it helps in grasping the structure of custom types or interfaces quickly.
      opts.desc = '[T]ype [D]efinition'
      keymap.set('n', '<leader>td', '<cmd>Telescope lsp_type_definitions<CR>', opts) -- show lsp type definitions

      -- Code Actions: Apply suggested fixes or refactorings.
      -- Automate tasks like fixing errors, importing libraries, or other quick fixes.
      opts.desc = '[C]ode [A]ction'
      keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)

      -- Rename Symbol: Refactor names of variables/functions across your project.
      -- Critical for maintaining clean, understandable code.
      opts.desc = '[R]e[n]ame'
      keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

      opts.desc = 'Show buffer diagnostics'
      keymap.set('n', '<leader>D', '<cmd>Telescope diagnostics bufnr=0<CR>', opts) -- show  diagnostics for file

      opts.desc = 'Show line diagnostics'
      keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts) -- show diagnostics for line

      -- Previous Diagnostic
      opts.desc = 'Go to previous diagnostic'
      keymap.set('n', '[d', vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

      -- Next Diagnostic
      opts.desc = 'Go to next diagnostic'
      keymap.set('n', ']d', vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer
    end

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    capabilities.textDocument.completion.completionItem = {
      documentationFormat = { 'markdown', 'plaintext' },
      snippetSupport = true,
      preselectSupport = true,
      insertReplaceSupport = true,
      labelDetailsSupport = true,
      deprecatedSupport = true,
      commitCharactersSupport = true,
      tagSupport = { valueSet = { 1 } },
      resolveSupport = {
        properties = {
          'documentation',
          'detail',
          'additionalTextEdits',
        },
      },
    }

    -- Change the Diagnostic symbols in the sign column (gutter)
    local signs = { Error = '󰅚 ', Warn = '  ', Hint = '󰛩 ', Info = ' ' } --    󰌶
    for type, icon in pairs(signs) do
      local hl = 'DiagnosticSign' .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
    end

    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
    vim.lsp.handlers['textDocument/signatureHelp'] =
      vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })
    require('lspconfig.ui.windows').default_options.border = 'rounded'
    vim.diagnostic.config({
      virtual_text = { prefix = '▣' },
      undercurl = true,
      float = { border = 'rounded', style = 'minimal' },
    })

    -- configure html server
    lspconfig['html'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- configure css server
    lspconfig['cssls'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- configure tailwindcss server
    lspconfig['tailwindcss'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = {
        'html',
        'css',
        'postcss',
        'javascript',
        'typescriptreact',
        'javascriptreact',
      },
    })

    -- configure emmet language server
    lspconfig['emmet_language_server'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'astro', 'svelte' },
    })

    -- configure json server
    lspconfig['jsonls'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- configure bash server
    lspconfig['bashls'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      completions = {
        completeFunctionCalls = true,
      },
      filetypes = { 'sh', 'bash', 'zsh' },
    })

    -- configure python server
    lspconfig['basedpyright'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        disableOrganizeImports = true, -- Using Ruff
        disableTaggedHints = false,
        verboseOutput = true,
        autoImportCompletion = true,
        basedpyright = {
          typeCheckingMode = 'standard',
          analysis = {
            indexing = true,
            autoImportCompletions = true,
            autoSearchPaths = true,
            diagnosticMode = 'openFilesOnly',
            useLibraryCodeForTypes = true,
            diagnosticSeverityOverrides = {
              reportIgnoreCommentWithoutRule = true,
            },
          },
        },
      },
    })

    -- configure Python ruff server
    lspconfig['ruff_lsp'].setup({
      -- capabilities = capabilities,
      -- on_attach = on_attach,
      handlers = {
        ['textDocument/publishDiagnostics'] = function() end,
      },
      -- https://docs.astral.sh/ruff/editors/settings
      init_options = {
        settings = {
          configuration = '~/Documents/ruff.toml',
          configurationPreference = 'filesystemFirst',
          lineLength = 88,
          fixAll = true,
          organizeImports = true,
          codeAction = {
            disableRuleComment = {
              enable = false,
            },
            fixViolation = {
              enable = true,
            },
          },
          lint = {
            preview = true,
          },
          format = {
            preview = true,
          },
        },
      },
      -- disable ruff as hover provider to avoid conflicts with pyright
      on_attach = function(client, bufnr)
        client.server_capabilities.hoverProvider = false
        on_attach(client, bufnr)
      end,
    })


    -- configure docker server
    lspconfig['dockerls'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
    -- configure docker compose server
    lspconfig['docker_compose_language_service'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- configure toml server
    lspconfig.taplo.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        evenBetterToml = {
          schema = { catalogs = { 'https://taplo.tamasfe.dev/schema_index.json' } },
        },
      },
    })

    -- configure yaml server
    lspconfig['yamlls'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab' },
      settings = {
        yaml = {
          format = {
            enable = true,
            singleQuote = true,
            bracketSpacing = false,
          },
          validate = true,
          completion = true,
          schemaStore = {
            enable = false,
            url = '',
          },
          -- manually select schemas
          schemas = {
            ['https://json.schemastore.org/kustomization.json'] = 'kustomization.{yml,yaml}',
            ['https://raw.githubusercontent.com/docker/compose/master/compose/config/compose_spec.json'] = '*compose*.{yml,yaml}',
            ['https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json'] = 'argocd-application.yaml',
            ['https://json.schemastore.org/github-action.json'] = 'action.{yml,yaml}',
            ['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*',
            ['https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json'] = {
              '**/.gitlab-ci.{yml,yaml}',
              '**/*.gitlab-ci.{yml,yaml}',
              'gitlab.{yml,yaml}',
            },
            kubernetes = { 'k8s**.yaml', 'kube*/*.yaml' },
          },
        },
      },
    })

    -- configure lua server (with special settings)
    lspconfig['lua_ls'].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = { -- custom settings for lua
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { 'vim' },
          },
          workspace = {
            -- make language server aware of runtime files
            library = {
              [vim.fn.expand('$VIMRUNTIME/lua')] = true,
              [vim.fn.stdpath('config') .. '/lua'] = true,
            },
          },
        },
      },
    })
  end,
}
