local api = vim.api

-- Set highlights for TabLine
vim.api.nvim_set_hl(0, 'TabLine', { fg = '#45475a', bg = 'None' })
vim.api.nvim_set_hl(0, 'TabLineSel', { fg = '#00bfff', bg = 'None', bold = true }) -- #5bcefc
vim.api.nvim_set_hl(0, 'TabLineFill', { fg = '#45475a', bg = 'None' })

-- Renders the tabline
function _G.custom_tabline()
  local tabline = ''

  -- Iterate through each buffer
  for buf = 1, vim.fn.bufnr('$') do
    if vim.fn.buflisted(buf) == 1 then
      local bufname = api.nvim_buf_get_name(buf)
      local buffer_number = buf
      local filename = vim.fn.fnamemodify(bufname, ':t')
      local extension = vim.fn.fnamemodify(bufname, ':e')
      local buf_ft = vim.bo[buf].filetype

      -- Get buffer name or [No Name]
      if filename == '' then
        filename = '[No Name]'
      end

      -- Filetype icon and color
      local icon, color = require('nvim-web-devicons').get_icon_color(filename, extension, { default = true })
      -- Ensure icon exists
      icon = icon or ''

      -- Define highlight. If the buffer is the current one, use 'TabLineSel', otherwise use 'TabLine'
      local is_current_buf = api.nvim_get_current_buf() == buf
      local highlight = is_current_buf and '%#TabLineSel#' or '%#TabLine#'

      -- Define the highlight group for the icon color
      local hl_group = 'TabLineDevIcon' .. buf_ft
      vim.api.nvim_command('highlight! ' .. hl_group .. ' guifg=' .. color .. ' guibg=None')

      -- Apply the highlight to the buffer number, icon, and filename
      tabline = tabline
        .. highlight
        .. buffer_number
        .. ': '
        .. '%#'
        .. hl_group
        .. '#'
        .. icon
        .. highlight
        .. ' '
        .. filename
        .. ' %*'
    end
  end

  -- Ensure the tabline is reset to normal highlighting
  tabline = tabline .. '%#TabLineFill#'
  return tabline
end

-- Set tabline
vim.o.tabline = '%!v:lua.custom_tabline()'
