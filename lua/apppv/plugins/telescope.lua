return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable('make') == 1
      end,
    },
    'nvim-tree/nvim-web-devicons',
    'nvim-telescope/telescope-ui-select.nvim',
  },
  config = function()
    local actions = require('telescope.actions')

    require('telescope').setup({
      defaults = {
        file_ignore_patters = {
          '%.git/.',
          'node_modules/.',
          'package.lock',
          'bun.lockb',
          'venv/.',
          '.venv/.',
        },
        path_display = { 'truncate' },
        mappings = {
          i = {
            ['<C-k>'] = actions.move_selection_previous, -- move to prev result
            ['<C-j>'] = actions.move_selection_next, -- move to next result
            ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
            --['<C-d>'] = actions.delete_buffer, -- delete buffer
          },
          n = {
            --['<C-d>'] = actions.delete_buffer, -- delete buffer
          },
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    })
    -- Enable telescope extensions, if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- set keymaps
    local keymap = vim.keymap -- for conciseness
    local builtin = require('telescope.builtin')

    -- Lists previously open files
    keymap.set('n', '<leader><leader>', builtin.oldfiles, { desc = '[F]ind [R]ecent files' })

    -- Lists open buffers in current neovim instance
    keymap.set('n', '<leader>bb', builtin.buffers, { desc = '[B]uffers List' })

    -- Lists files in your current working directory, respects .gitignore
    keymap.set(
      'n',
      '<leader>ff',
      '<cmd>:Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>',
      { desc = '[F]ind [F]iles in cwd' }
    )

    -- List git files
    keymap.set('n', '<leader>gf', builtin.git_files, { desc = '[G]it [F]iles' })

    -- Show git status
    keymap.set('n', '<leader>gt', builtin.git_status, { desc = '[G]it S[t]atus' })

    -- Lists Diagnostics for all open buffers or a specific buffer. Use option bufnr=0 for current buffer.
    keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })

    -- Search for a string in your current working directory and get results live as you type, respects .gitignore
    keymap.set('n', '<leader>fs', builtin.live_grep, { desc = '[F]ind [S]tring in cwd' })

    -- Searches for the string under your cursor or selection in your current working directory
    keymap.set('n', '<leader>fc', builtin.grep_string, { desc = '[F]ind string under [C]ursor in cwd' })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
        winblend = 90,
        previewer = false,
      }))
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep({
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      })
    end, { desc = '[S]earch [/] in Open Files' })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files({ cwd = vim.fn.stdpath('config') })
    end, { desc = '[S]earch [N]eovim files' })

    -- Shortcut to search notes
    vim.keymap.set('n', '<leader>nn', function()
      builtin.find_files({ cwd = '~/workspace/NOTES' })
    end, { desc = 'Find [N]otes' })
  end,
}
