-- Everything *line & Winbar

vim.opt.laststatus = 3
vim.opt.showmode = false
vim.opt.showtabline = 2

-- Set Statusline
require('apppv.config.statusline')

-- Nice split separator
vim.api.nvim_set_hl(0, 'WinSeparator', { bg = None })

-- Set Winbar
vim.opt.winbar = "%{%v:lua.require('apppv.config.winbarrio').eval()%}"

-- Set Buffline
require('apppv.config.buffline')
