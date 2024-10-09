local function highlight_telescope(hl, c)
  local prompt = c.bg
  hl.TelescopeNormal = {
    bg = c.bg,
    fg = c.fg,
  }
  hl.TelescopeBorder = {
    bg = c.bg,
    fg = c.bg,
  }
  hl.TelescopePromptNormal = {
    bg = prompt,
  }
  hl.TelescopePromptBorder = {
    bg = prompt,
    fg = prompt,
  }
  hl.TelescopePromptTitle = {
    bg = c.bg_highlight,
    fg = c.fg,
  }
  hl.TelescopePreviewTitle = {
    bg = c.bg,
    fg = c.bg,
  }
  hl.TelescopeResultsTitle = {
    bg = c.bg,
    fg = c.bg,
  }
  hl.NoiceCmdlinePopupBorder = {
    bg = c.bg,
    fg = c.bg,
  }
end

return {
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000,
  opts = {
    style = 'storm',
    transparent = true,
    styles = {
      sidebars = 'transparent',
      floats = 'transparent',
    },
    on_highlights = function(hl, c)
      highlight_telescope(hl, c)
    end,
  },
  config = function(_, opts)
    local tokyonight = require('tokyonight')
    tokyonight.setup(opts)
    tokyonight.load()
    vim.cmd('highlight Search guibg=#E58AC8 guifg=#1D1E2C')

    vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
  end,
}
