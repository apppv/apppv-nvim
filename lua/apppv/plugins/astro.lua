return {
  'nvim-tree/nvim-web-devicons',
  -- Add icon for astro files
  config = function()
    require('nvim-web-devicons').setup({
      strict = false,
      override_by_extension = {
        astro = {
          icon = '',
          color = '#FFFFFF', -- #EF8547
          name = 'astro',
        },
      },
    })
  end,
}
