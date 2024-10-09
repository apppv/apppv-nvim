--*******************************************************--
--                                                       --
--                       Lazy.nvim                       --
--                                                       --
--*******************************************************--
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require('lazy').setup({
  { import = 'apppv.plugins' },
  { import = 'apppv.plugins.lsp' },
  install = {
    -- install missing plugins on startup. This doesn't increase startup time.
    missing = true,
    -- try to load one of these colorschemes when starting an installation during startup
    colorscheme = { 'night-owl' },
  },
  defaults = { lazy = true, version = false },
  checker = { enabled = true, notify = true }, -- Check for plugin updates.
  debug = false,
  ui = { border = 'rounded' },
  performance = { -- Disable some builtin plugins
    rtp = {
      disabled_plugins = {
        '2html_plugin',
        'tohtml',
        'getscript',
        'getscriptPlugin',
        'gzip',
        'logipat',
        'matchit',
        'tar',
        'tarPlugin',
        'rrhelper',
        'spellfile_plugin',
        'vimball',
        'vimballPlugin',
        'zip',
        'zipPlugin',
        'rplugin',
        'optwin',
        'bugreport',
      },
    },
  },
})
