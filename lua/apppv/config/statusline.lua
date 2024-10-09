-- https://nuxsh.is-a.dev/blog/custom-nvim-statusline.html#org4e437d4

-- vim.api.nvim_set_hl(0, 'NormalAccent', { fg = "#f8f8f2", bg = "#0d1220" })
vim.api.nvim_set_hl(0, 'StatusLineAccent', { fg = '#f8f8f2', bg = '#1C64F2' })
vim.api.nvim_set_hl(0, 'StatuslineInsertAccent', { fg = '#f8f8f2', bg = '#ff0080' })
vim.api.nvim_set_hl(0, 'StatuslineVisualAccent', { fg = '#f8f8f2', bg = '#00ffff' })
vim.api.nvim_set_hl(0, 'StatuslineReplaceAccent', { fg = '#f8f8f2', bg = '#ff4af1' })
vim.api.nvim_set_hl(0, 'StatuslineCmdLineAccent', { fg = '#f8f8f2', bg = '#ffd700' })
vim.api.nvim_set_hl(0, 'StatuslineTerminalAccent', { fg = '#333333', bg = '#00ffff' })

vim.api.nvim_set_hl(0, 'StatusLineExtra', { fg = '#f8f8f2', bg = '#1C64F2' })
vim.api.nvim_set_hl(0, 'StatusLineExtraSep', { fg = '#1C64F2' })
vim.api.nvim_set_hl(0, 'StatusLineLinePercentage', { fg = '#828282' })
vim.api.nvim_set_hl(0, 'StatusLineLineInfo', { fg = '#979797' })

vim.api.nvim_set_hl(0, 'ModifiedAccent', { fg = '#ffd700' })
vim.api.nvim_set_hl(0, 'ViAccent', { fg = '#00BFFF', bg = 'NONE' }) -- #bcbcbc nice gray #fa3232 red!
vim.api.nvim_set_hl(0, 'ViSepAccent', { fg = '#00bfff', bg = 'NONE' })

vim.api.nvim_set_hl(0, 'GitBranchAccent', { fg = '#bd2c00' })
vim.api.nvim_set_hl(0, 'GitBranchName', { fg = '#EDEADE' })

vim.api.nvim_set_hl(0, 'ErrorsAccent', { fg = '#ff0000' })
vim.api.nvim_set_hl(0, 'WarningsAccent', { fg = '#ffd700' })
vim.api.nvim_set_hl(0, 'InfoAccent', { fg = '#00aeff' })
vim.api.nvim_set_hl(0, 'HintsAccent', { fg = '#00ffff' })

local modes = {
  ['n'] = 'Normal',
  ['no'] = 'O-Pending',
  ['nov'] = 'O-Pending',
  ['noV'] = 'O-Pending',
  ['no\x16'] = 'O-Pending',
  ['niI'] = 'Normal',
  ['niR'] = 'Normal',
  ['niV'] = 'Normal',
  ['nt'] = 'Normal',
  ['ntT'] = 'Normal',
  ['v'] = 'Visual',
  ['vs'] = 'Visual',
  ['V'] = 'V-Line',
  ['Vs'] = 'V-Line',
  ['\x16'] = 'V-Block',
  ['\x16s'] = 'V-Block',
  ['s'] = 'Select',
  ['S'] = 'S-Line',
  ['\x13'] = 'S-Block',
  ['i'] = 'Insert',
  ['ic'] = 'Insert',
  ['ix'] = 'Insert',
  ['R'] = 'Replace',
  ['Rc'] = 'Replace',
  ['Rx'] = 'Replace',
  ['Rv'] = 'V-Replace',
  ['Rvc'] = 'V-Replace',
  ['Rvx'] = 'V-Replace',
  ['c'] = 'Command',
  ['cv'] = 'Ex',
  ['ce'] = 'Ex',
  ['r'] = 'Replace',
  ['rm'] = 'More',
  ['r?'] = 'Confirm',
  ['!'] = 'Shell',
  ['t'] = 'Terminal',
}

local function mode()
  local current_mode = vim.api.nvim_get_mode().mode
  return string.format(' %s ', modes[current_mode]):upper()
end

local function update_mode_colors()
  local current_mode = vim.api.nvim_get_mode().mode
  local mode_color = '%#StatusLineAccent#'
  if current_mode == 'n' then
    mode_color = '%#StatuslineAccent#'
  elseif current_mode == 'i' or current_mode == 'ic' then
    mode_color = '%#StatuslineInsertAccent#'
  elseif current_mode == 'v' or current_mode == 'V' or current_mode == '' then
    mode_color = '%#StatuslineVisualAccent#'
  elseif current_mode == 'R' then
    mode_color = '%#StatuslineReplaceAccent#'
  elseif current_mode == 'c' then
    mode_color = '%#StatuslineCmdLineAccent#'
  elseif current_mode == 't' then
    mode_color = '%#StatuslineTerminalAccent#'
  end
  return mode_color
end

local function filename()
  local fname = vim.fn.expand('%:p:t')
  if fname == '' then
    fname = ' [No Name]'
  else
    local extension = vim.fn.expand('%:e')
    local icon, color = require('nvim-web-devicons').get_icon_color(fname, extension, { default = true })
    local hl_group = 'StatusLineDevIcon' .. extension
    vim.api.nvim_set_hl(0, hl_group, { fg = color, bg = 'None' })
    fname = string.format('%%#%s#%s%%#Normal# %s', hl_group, icon, fname)
  end
  return fname .. ' '
end

local function lsp()
  local count = {}
  local levels = {
    errors = 'Error',
    warnings = 'Warn',
    info = 'Info',
    hints = 'Hint',
  }

  for k, level in pairs(levels) do
    count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
  end

  local errors = ''
  local warnings = ''
  local hints = ''
  local info = ''

  if count['errors'] ~= 0 then
    errors = ' %#LspDiagnosticsSignError#%#ErrorsAccent#󰅚 ' .. count['errors']
  end
  if count['warnings'] ~= 0 then
    warnings = ' %#LspDiagnosticsSignWarning#%#WarningsAccent# ' .. count['warnings']
  end
  if count['hints'] ~= 0 then
    hints = ' %#LspDiagnosticsSignHint#%#HintsAccent#󰛩 ' .. count['hints']
  end
  if count['info'] ~= 0 then
    info = ' %#LspDiagnosticsSignInformation#%#InfoAccent# ' .. count['info']
  end

  return errors .. warnings .. hints .. info
end

local function filetype()
  return string.format(' %s ', vim.bo.filetype):upper()
end

local function lineinfo()
  if vim.bo.filetype == 'alpha' then
    return ''
  end
  return ' %#StatusLineLineInfo#%l/%L:%c'
end

local function filepercent()
  if vim.bo.filetype == 'alpha' then
    return ''
  end
  return ' %#StatusLineLinePercentage#%p%% '
end

-- Function to show modified status with a custom icon
local function modified()
  return vim.bo.modified and '%#ModifiedAccent# ' or ''
end

local function git_branch()
  local branch = vim.fn.system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
  return branch ~= '' and ('%#GitBranchAccent# %#GitBranchName#' .. branch) or ''
end

local vcs = function()
  local git_info = vim.b.gitsigns_status_dict
  if not git_info or git_info.head == '' then
    return ''
  end
  local added = git_info.added and ('%#GitSignsAdd#+' .. git_info.added .. ' ') or ''
  local changed = git_info.changed and ('%#GitSignsChange#~' .. git_info.changed .. ' ') or ''
  local removed = git_info.removed and ('%#GitSignsDelete#-' .. git_info.removed .. ' ') or ''
  if git_info.added == 0 then
    added = ''
  end
  if git_info.changed == 0 then
    changed = ''
  end
  if git_info.removed == 0 then
    removed = ''
  end
  return table.concat({
    ' ',
    added,
    changed,
    removed,
    ' ',
    --'%#GitBranchAccent# %#GitBranchName#',
    --git_info.head,
    ' %#Normal#',
  })
end

Statusline = {}

Statusline.render = function()
  return table.concat({
    '%#Statusline#',
    '%#ViSepAccent# ▊ ',
    '%#ViAccent#  ',
    update_mode_colors(),
    mode(),
    '%#Normal# ',
    git_branch(),
    '%#Normal# ',
    vcs(),
    '%=',
    filename(),
    modified(),
    lsp(),
    '%#Normal# ',
    '%=',
    filetype(),
    filepercent(),
    '%#StatusLineExtraSep#',
    '%#StatusLineExtra#',
    '%#StatusLineExtraSep#█',
    lineinfo(),
    '%#ViSepAccent# ▊ ',
  })
end

-- Create an autogroup for the statusline
local statusline_group = vim.api.nvim_create_augroup('Statusline', { clear = true })

-- Set autocommand to update the statusline on buffer/window enter
vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, {
  group = statusline_group,
  callback = function()
    vim.opt_local.statusline = '%!v:lua.Statusline.render()'
  end,
})
