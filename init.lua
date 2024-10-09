--*******************************************************--
--                                                       --
--                  init.lua for PDE                     --
--           Personalized Development Environment        --
--                                                       --
--*******************************************************--

-----------------------------------------------------------
--           Improve startup time for Neovim             --
-----------------------------------------------------------
-- To enable the loader
-- Add the following at the top of your init.lua:
if vim.fn.has('nvim') then
  -- Use nvim 0.9+ new loader with byte-compilation cache
  -- https://neovim.io/doc/user/lua.html#vim.loader
  if vim.loader then
    vim.loader.enable()
  end
end

-----------------------------------------------------------
--       Enable smooth scrolling for nvim >= 0.10        --
-----------------------------------------------------------
if vim.fn.has('nvim-0.10') == 1 then
  vim.opt.smoothscroll = true
  vim.opt.joinspaces = false
end

-----------------------------------------------------------
--                Define providers paths                 --
-----------------------------------------------------------
-- Python This must be here because it makes loading vim VERY SLOW otherwise
vim.g.python_host_skip_check = 1
vim.g.python3_host_skip_check = 1
-- Disable Python2 provider
vim.g.loaded_python_provider = 0
-- Define python path, where pynvim is installed. This is to use python venvs without the need to install pynvim everytime.
if vim.fn.executable('python3') == 1 then
  vim.g.python3_host_prog = vim.fn.exepath('python3')
else
  vim.g.loaded_python3_provider = 0
end
-- python -m pip install --user --upgrade pynvim
-- https://github.com/deoplete-plugins/deoplete-jedi/wiki/Setting-up-Python-for-Neovim

-- vim.g.node_host_prog = "/usr/local/bin/neovim-node-host"
-- npm install -g neovim
-- https://neovim.io/doc/user/provider.html#g%3Aloaded_node_provider

-- vim.g.ruby_host_prog = 'rvm system do neovim-ruby-host'
-- https://neovim.io/doc/user/provider.html#g%3Aruby_host_prog

-----------------------------------------------------------
--           Disable some default providers              --
-----------------------------------------------------------
vim.g.loaded_perl_provider = 0
-- for _, provider in ipairs({ "perl", "ruby" }) do
--   vim.g["loaded_" .. provider .. "_provider"] = 0
-- end

-----------------------------------------------------------
--                       IMPORTS                         --
-----------------------------------------------------------

require('apppv.config.mappings') -- Keymaps
require('apppv.lazy') -- Lazy.nvim
require('apppv.config.options') -- Options
require('apppv.config.ui') -- UI
require('apppv.config.utils') -- Utils
require('apppv.config.terminal') -- Terminal
require('apppv.config.custom_commands') -- Custom commands
