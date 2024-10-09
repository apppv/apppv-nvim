return {
  {
    'nvim-treesitter/nvim-treesitter',
    version = false, -- last release is way too old and doesn't work on Windows
    build = ':TSUpdate',
    event = { 'LazyFile', 'VeryLazy' },
    lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
    dependencies = {
      'windwp/nvim-ts-autotag',
    },
    init = function(plugin)
      -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
      -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
      -- no longer trigger the **nvim-treesitter** module to be loaded in time.
      -- Luckily, the only things that those plugins need are the custom queries, which we make available
      -- during startup.
      require('lazy.core.loader').add_to_rtp(plugin)
      require('nvim-treesitter.query_predicates')
    end,
    cmd = { 'TSUpdateSync', 'TSUpdate', 'TSInstall' },
    keys = {
      { '<c-space>', desc = 'Increment Selection' },
      { '<bs>', desc = 'Decrement Selection', mode = 'x' },
    },
    opts_extend = { 'ensure_installed' },
    opts = {
      highlight = {
        enable = true,
      },
      -- enable indentation
      indent = {
        enable = true,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        additional_vim_regex_highlighting = false,
      },
      -- enable autotag
      autotag = {
        enable = true,
        filetypes = {
          'html',
          'eruby',
          'javascript',
          'javascriptreact',
          'typescriptreact',
          'astro',
          'php',
        },
      },

      -- ensure these language parsers are installed
      ensure_installed = {
        'html',
        'http',
        'css',
        'postcss',
        'styled',
        'javascript',
        'javascriptreact',
        'typescript',
        'tsx',
        'astro',
        'jsdoc',
        'json',
        'json5',
        'jsonc',
        'jq',
        'sql',
        'markdown',
        'markdown_inline',
        'bash',
        'lua',
        'luadoc',
        'luap',
        'vim',
        'vimdoc',
        'make',
        'dockerfile',
        'yaml',
        'toml',
        'ini',
        'git_config',
        'gitignore',
        'gitcommit',
        'diff',
        'printf',
        'scheme',
        'comment',
        'query',
        'dot',
        'regex',
        'help',
        'rst',
        'rust',
        'python',
        'ruby',
        'elixir',
        'heex',
        'eex',
        'nix',
        'tmux',
      },
      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-space>',
          node_incremental = '<C-space>',
          scope_incremental = false,
          node_decremental = '<bs>',
        },
      },
      textobjects = {
        move = {
          enable = true,
          goto_next_start = { [']f'] = '@function.outer', [']c'] = '@class.outer' },
          goto_next_end = { [']F'] = '@function.outer', [']C'] = '@class.outer' },
          goto_previous_start = { ['[f'] = '@function.outer', ['[c'] = '@class.outer' },
          goto_previous_end = { ['[F'] = '@function.outer', ['[C'] = '@class.outer' },
        },
      },
    },
    config = function(_, opts)
      require('nvim-treesitter.install').prefer_git = true
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
  -- Automatically add closing tags for HTML and JSX
  {
    'windwp/nvim-ts-autotag',
    event = 'LazyFile',
    opts = {},
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    config = true,
    event = 'BufReadPre',
  },
}
