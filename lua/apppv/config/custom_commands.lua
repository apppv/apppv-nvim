-- [[ Custom User Commands ]]

-- Function to remove empty new lines
vim.api.nvim_create_user_command('TrimLines', function()
  vim.cmd('g/^$/d')
end, {})

-- Function to remove trailing white spaces
vim.api.nvim_create_user_command('TrimWhitespace', function()
  vim.cmd('%s/\\s\\+$//e')
end, {})

-- Function to copy current file's path into the clipboard
vim.api.nvim_create_user_command('CopyPath', function()
  vim.fn.setreg('+', vim.fn.expand('%:p'))
end, {})

-- Function to ripgrep BG IDs
vim.api.nvim_create_user_command('BGID', function()
  vim.cmd('%!rg -o "\\b1[0-9]{7}\\b"')
end, {})

-- Function to convert new lines to comma, without a trailing comma
vim.api.nvim_create_user_command('NewlineToComma', function()
  vim.cmd('%s/\\n/, /g | %s/, \\%$//')
end, {})

-- Create command to put the word under the cursor inside single quotes
vim.api.nvim_create_user_command('QuoteSingle', function()
  -- Function to put the word under cursor inside single quotes
  local function quote_single()
    -- Get the current word under the cursor
    local word = vim.fn.expand('<cword>')
    -- Replace the word under cursor with the quoted word
    vim.cmd("normal! ciw'" .. word .. "'")
  end
  quote_single()
end, {})

-- Create command to put the word under the cursor inside double quotes
vim.api.nvim_create_user_command('QuoteDouble', function()
  -- Function to put the word under cursor inside double quotes
  local function quote_double()
    -- Get the current word under the cursor
    local word = vim.fn.expand('<cword>')
    -- Replace the word under cursor with the quoted word
    vim.cmd('normal! ciw"' .. word .. '"')
  end
  quote_double()
end, {})

-- Create a command to open the current file/buffer
vim.api.nvim_create_user_command('Open', function()
  -- Function to open the current file/buffer
  local function open_current_file()
    vim.ui.open(vim.fn.expand('%'))
  end
  open_current_file()
end, {})

require('apppv.config.terminal')
-- Example specific commands to run commands in a terminal
-- Create the command "Docker" that opens lazydocker in a terminal
vim.api.nvim_create_user_command('Lazydocker', function()
  run_command_in_floating_terminal('lazydocker')
end, {})

-- Create the command "NpmDev" that runs "npm run dev" in a terminal
vim.api.nvim_create_user_command('NpmDev', function()
  run_command_in_terminal('npm run dev')
end, {})

local commands = {
  { name = 'Lazydocker', description = 'Open Lazy Docker' },
  { name = 'NpmDev', description = 'Execute npm run dev' },
}

vim.api.nvim_create_user_command('SelectCommand', function()
  vim.ui.select(commands, {
    prompt = 'Select a command to run:',
    format_item = function(item)
      return item.description
    end,
  }, function(choice)
    if choice then
      vim.cmd(choice.name)
    end
  end)
end, {})
