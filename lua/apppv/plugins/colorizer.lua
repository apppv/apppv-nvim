return {
  'NvChad/nvim-colorizer.lua',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    require('colorizer').setup({
      filetypes = { 'html', 'css', 'javascript', 'lua', 'go', 'python' },
      buftypes = { 'html', 'css', 'javascript' },
      user_default_options = {
        tailwind = false,
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        RRGGBBAA = false, -- #RRGGBBAA hex codes
        AARRGGBB = false, -- 0xAARRGGBB hex codes
        names = false,
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        mode = 'background', -- Set the display mode.
        method = 'both',
        always_update = true,
      },
    })
  end,
}
