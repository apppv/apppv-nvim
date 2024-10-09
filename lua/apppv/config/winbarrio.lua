-- https://gist.github.com/s1n7ax/3d2b476ecbde72693572b8652044e5a4

local M = {}

vim.api.nvim_set_hl(0, 'WinBarPath', { fg = '#b8c0e0', bg = 'None' })
vim.api.nvim_set_hl(0, 'PathSep', { fg = '#313244', bg = 'None' })
vim.api.nvim_set_hl(0, 'WinBarBuffer', { fg = '#74c7ec' })

local winbar_filetype_exclude = {
  'help',
  'NvimTree',
  'Trouble',
  'netrw',
  'NetrwTreeListing',
  'terminal',
}

function M.eval()
  -- Check if the current buffer contains excluded filetypes, return empty if it is
  if vim.tbl_contains(winbar_filetype_exclude, vim.bo.filetype) then
    return ''
  end

  if vim.bo.buftype == 'terminal' then
    return ''
  end

  local right_align = '%='
  local file_path = vim.fn.expand('%:p:~')
  local buffer_nr = vim.api.nvim_eval_statusline('  [%n]', {}).str

  -- Remove the first '~' if it exists and replaces it with home icon.
  if file_path:sub(1, 1) == '~' then
    file_path = '  ' .. file_path:sub(2)
  end

  -- Remove the first '/' if it exists and replaces it with lock icon.
  if file_path:sub(1, 1) == '/' then
    file_path = '   ' .. file_path:sub(2)
  end

  file_path = file_path:gsub('/', ' ') -- 

  return '%#WinBarPath#' .. file_path .. '%*' .. '%#WinBarBuffer#' .. buffer_nr .. '%*'
end

return M
