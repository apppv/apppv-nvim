--********************************************************--
--       General Neovim settings and configuration        --
--********************************************************--

-----------------------------------------------------------
-- Neovim UI configuration                               --
-----------------------------------------------------------

-- don't bother updating screen during macro playback
vim.opt.lazyredraw = true

-- No beeping.
vim.opt.visualbell = false

-- No flashing.
vim.opt.errorbells = false

-----------------------------------------------------------
-- General Neovim settings and configuration             --
-----------------------------------------------------------

-- Default options are not included
-- See: https://neovim.io/doc/user/vim_diff.html
-- [2] Defaults - *nvim-defaults*

--*******************************************************--
--                                                       --
--                  General Neovim Options               --
--                                                       --
--*******************************************************--

vim.opt.confirm = true -- confirm to save

vim.opt.modifiable = true

--    [[ Allow cursor to move past the end of the line and wrap around ]]
vim.opt.whichwrap:append('<,>,[,],h,l')

--    [[ Consider the hyphen '-' as part of a word ]]
vim.cmd([[set iskeyword+=-]])

vim.opt.clipboard:append({ 'unnamedplus' }) -- macOS

-----------------------------------------------------------
--                  Swap, Backup, Undo                   --
-----------------------------------------------------------
vim.opt.swapfile = false -- bool: Don't use swapfile
vim.opt.backup = false -- bool: Don't use backupfile
vim.opt.writebackup = false

--    [[ Undodir Setup ]]
local undodir = os.getenv('HOME') .. '/.config/nvim/undodir'
-- local undodir = vim.fn.stdpath('config') .. "/.undo"

if vim.fn.has('persistent_undo') == 1 then
  if vim.fn.isdirectory(undodir) == 0 then
    os.execute('mkdir -p ' .. undodir)
  end

  vim.opt.undodir = undodir
  vim.opt.undofile = true
end

-----------------------------------------------------------
--                       General                         --
-----------------------------------------------------------
--    [[ Context ]]
vim.opt.number = true -- bool: Show line numbers
vim.opt.relativenumber = true -- bool: Show relative line numbers
vim.o.cursorline = true -- bool: Highlight the current line
vim.opt.showmatch = true -- bool: Highlights the matching parenthesis, bracket, or brace when the cursor is over one of them.
vim.opt.backspace = 'indent,eol,nostop' -- str:  Allow backspacing over everything in insert mode
vim.opt.colorcolumn = '120' -- str:  Set a vertical line at column 120
vim.opt.signcolumn = 'yes' -- str:  Show the sign column(always, with fixed space for signs up to the given number)
vim.opt.virtualedit = 'block' -- str:  Allow virtual editing in Visual block mode
vim.opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize' }
vim.opt.tildeop = true -- Make tilde command behave like an operator.

vim.opt.sidescrolloff = 8
vim.opt.scrolloff = 8 -- int:  Min number lines of context
--[[
    Controls the number of lines to keep above and below the cursor when scrolling.
    Setting it to 8 ensures that there are always at least 8 lines above and below the cursor when scrolling.
]]
--

--    [[ Whitespace ]]
vim.opt.autoindent = true -- bool: Automatically adjust indentation
vim.opt.expandtab = true -- bool: Use spaces instead of tabs
vim.opt.shiftwidth = 2 -- int:  Size of an indent
vim.opt.softtabstop = 2 -- int:  Number of spaces tabs count for in insert mode
vim.opt.tabstop = 2 -- int:  Number of spaces tabs count for
vim.opt.shiftround = true -- bool: When using the shift commands (<< and >>), this option rounds the shift operation to the nearest 'shiftwidth'.

--    [[ Filetypes ]]
vim.opt.encoding = 'utf8' -- str:  String encoding to use
vim.opt.fileencoding = 'utf8' -- str:  File encoding to use
vim.opt.title = true -- bool: Show file title in terminal's title bar
vim.g.do_filetype_lua = 1 -- Enable filetype.lua
-- vim.g.did_load_filetypes = 0      -- Disable filetype.vim
vim.opt.filetype = 'on' -- str:  Enable filetype detection
vim.opt.autoread = true -- bool: This automatically reloads a file if it has been changed outside of Vim.
vim.opt.conceallevel = 0 -- int:  Making `` visible in markdown files

--    [[ Enabling all 3 options provides a more pleasant editing experience ]]
vim.opt.linebreak = true -- bool: Line break
vim.opt.wrap = true -- bool: Line wrap
vim.opt.breakindent = true -- bool: Enable breakindent

--    [[ Terminal and Mouse Support ]]
vim.opt.mouse = 'a' -- Disable mouse
vim.opt.ttyfast = true -- bool: Speed up scrolling in Neovim (TTY)
vim.opt.wildmenu = true -- bool: Enhance the command-line experience by showing a more advanced menu for command-line completion.
vim.opt.wildmode = 'longest:full,list,full' -- Show a navigable menu for tab completion
vim.opt.wildoptions = 'pum'
vim.opt.showcmd = true -- bool: Displays the command being typed in the last line of the screen, giving you visual feedback as you type Ex commands.
vim.opt.shell = '/bin/zsh' -- str:  Specifies the shell that Neovim should use for running external commands.
vim.opt.cmdheight = 1 -- int:  Set the command-line height
vim.opt.shellcmdflag = '-ic' -- Set shell command flags to launch as an interactive login shell.
-- This ensures your shell's login scripts are sourced,
-- making your environment variables and aliases/functions available.

--    [[ Splits ]]
vim.opt.splitright = true -- bool: Place new window to right of current one
vim.opt.splitbelow = true -- bool: Place new window below the current one
vim.opt.inccommand = 'split' -- str:  Sets how replacements are displayed when using the :substitute command. It displays replacements in a split screen.
vim.opt.splitkeep = 'screen' -- str:  The current view of the window (what you see on screen) is preserved when opening/closing splits.

--    [[ Search ]]
vim.opt.ignorecase = true -- bool: Ignore case in search patterns
vim.opt.smartcase = true -- bool: Override ignorecase if search contains capitals. Case-insensitive searching UNLESS \C or capital in search.
vim.opt.incsearch = true -- bool: Use incremental search
vim.opt.hlsearch = true -- bool: Highlight search matches

-- [[ Coding ]]
vim.opt.wildignore =
  '*.o,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store,*/node_modules/*,*/.ruff_cache/*,*/site-packages/*,*/*_cache/*,*/.ipynb_checkpoints/*,*/__pypackages__/*'

if vim.fn.executable('rg') then
  -- if ripgrep installed, use that as a grepper
  -- vim.opt.grepprg = 'rg --vimgrep --no-heading --smart-case'
  vim.opt.grepformat = '%f:%l:%c:%m,%f:%l:%m'
  vim.opt.grepprg = 'rg --smart-case --vimgrep --no-heading --follow --multiline-dotall --hidden --pcre2 --regexp'
  -- IMPORTANT: pipes should be escaped! e.g. `"text\.(Success\|Info)\("`
end

if vim.fn.executable('prettier') then
  vim.opt.formatprg = 'prettier --stdin-filepath=%'
end

vim.opt.formatoptions = 'l'
vim.opt.formatoptions = vim.opt.formatoptions
  - 'a' -- Auto formatting is BAD.
  - 't' -- Don't auto format my code. I got linters for that.
  + 'c' -- In general, I like it when comments respect textwidth
  - 'o' -- O and o, don't continue comments
  + 'r' -- But do continue when pressing enter.
  + 'n' -- Indent past the formatlistpat, not underneath it.
  + 'j' -- Auto-remove comments if possible.
  - '2' -- I'm not in gradeschool anymore

--    [[ Completion Menu ]]
vim.opt.completeopt = 'menu,menuone,noinsert,noselect' --  Configure completion menu behavior
--    'noinsert': Prevents the inserted text from being replaced by the selected completion item.
--    'menuone': Shows the menu even when there's only one match.
--    'noselect': Allows you to use the Tab key to navigate through the completion menu without actually selecting an item.

--    [[ Theme ]]
vim.g.syntax = 'on' -- str:  Enable syntax highlighting, which colorizes different elements in your code to make it more readable and understandable.
if vim.fn.has('termguicolors') == 1 then
  vim.o.termguicolors = true
end -- bool: Enable 24-bit RGB colors
vim.opt.guifont = 'MonaspiceAr Nerd Font Mono:h18'
vim.g.background = 'dark' -- str:  Set background(dark/light)
vim.opt.pumheight = 20 -- int:  Popup-menu height; maximum number of items to show in the popup-menu
vim.opt.pumblend = 20 -- int:  Enables pseudo-transparency for popup-menu(default 0)
vim.opt.winblend = 30 -- int:  Enables pseudo-transparency for floating window(default 0)
--[[
    Valid values are in
    the range of 0 for fully opaque window (disabled) to 100 for fully
    transparent background. Values between 0-30 are typically most useful.
--]]

--    [[ Memory, CPU ]]
vim.opt.history = 100 -- int:  Remember N lines in history
vim.opt.lazyredraw = true -- bool: Faster scrolling
vim.opt.ttyfast = true -- bool: Speed up scrolling in Neovim (TTY)
vim.opt.synmaxcol = 240 -- int:  Max column for syntax highlight
vim.opt.updatetime = 150 -- int:  Time in milliseconds to wait to wait for trigger an event.
vim.opt.timeoutlen = 100 -- int:  Time in milliseconds to wait for a mapped sequence to complete.

--    [[ Buffer Management ]]
vim.opt.hidden = true -- bool: Allow hiding buffers
--[[
    It allows you to switch between buffers without saving changes, and the modified buffers are kept in the background without being closed.
    This is useful when working with multiple buffers, as you can switch between them without being forced to save or discard changes immediately.
--]]

-- [[ Indent blankline replacement ]]
vim.opt.list = true
vim.opt.listchars = { leadmultispace = '┆ ', nbsp = '␣', trail = '‗' } -- eol = "󰌑"
vim.opt.listchars:append('tab: ⇆ ')

-- [[ Some UI Settings ]]
vim.opt.laststatus = 3
vim.opt.showmode = false
vim.opt.showtabline = 2

vim.api.nvim_set_hl(0, 'WinSeparator', { bg = None })

-- Make sure diffs are always opened in vertical splits, also match my git settings
vim.opt.diffopt:append('vertical,algorithm:histogram,indent-heuristic,hiddenoff')

if vim.fn.has('nvim-0.9') > 0 then
  vim.opt.diffopt:append('linematch:60')
end

-----------------------------------------------------------
--                       Startup                         --
-----------------------------------------------------------
--    [[ Disable nvim intro ]]
-- vim.opt.shortmess:append "sI"

--    [[ Make completion messages shorter (e.g., don't show "match 1 of 2" messages) ]]
vim.opt.shortmess:append('c')
