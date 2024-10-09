vim.bo.shiftwidth = 4
vim.bo.tabstop = 4
vim.bo.softtabstop = 4
vim.bo.expandtab = true
vim.bo.autoindent = true

vim.bo.textwidth = 120

-- [[ Python toggle f-string ]]
require('apppv.config.toggle-f-string')

-- Python specific commands
vim.keymap.set(
  'n',
  '<leader>rp',
  ":w <bar> exec '!python3 '.shellescape('%')<CR>",
  { silent = true, desc = '[R]un [P]ython file' }
)

-- Function to prompt user for CLI arguments and run the current Python file
local function run_python_with_args()
  -- Prompt the user for input
  vim.ui.input({ prompt = 'Enter CLI arguments for Python script: ' }, function(input)
    if input then
      -- Save the current buffer
      vim.cmd('w')
      -- Construct the command with user input
      local command = '!python3 ' .. vim.fn.shellescape(vim.fn.expand('%')) .. ' ' .. input
      -- Execute the command
      vim.cmd("exec '" .. command .. "'")
    else
      print('User cancelled the input.')
    end
  end)
end

-- Create a command to call the function
vim.api.nvim_create_user_command(
  'RunPy',
  run_python_with_args,
  { desc = 'Run Python file with user-provided CLI arguments' }
)
