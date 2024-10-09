-- Define a function to open a terminal in a bottom split without running a command
local function open_terminal()
  -- Split the window and open terminal
  vim.cmd('botright split')
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_current_buf(buf)
  vim.cmd.wincmd('J')
  vim.api.nvim_win_set_height(0, 12)
  vim.wo.winfixheight = true
  vim.fn.termopen(vim.o.shell)
end

-- Create the command "Term" that calls the open_terminal function
vim.api.nvim_create_user_command('Term', function()
  open_terminal()
end, {})

-- Create an autocommand to automatically start insert mode when opening a terminal
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = 'term://*',
  callback = function()
    -- Set buffer-local keymap from <Esc> to <C-\\><C-n> in terminal mode
    vim.api.nvim_buf_set_keymap(0, 't', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })

    -- Enter insert mode automatically
    vim.cmd('startinsert')

    -- Disable line numbers in this terminal buffer
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.scrolloff = 0
  end,
})

-- Function to open a floating terminal window without running a command
local function floating_terminal()
  -- Define the floating window size and position
  local width = vim.api.nvim_get_option('columns') - 20
  local height = vim.api.nvim_get_option('lines') - 10
  local row = 5
  local col = 10

  -- Ensure width and height are integers
  width = math.floor(width)
  height = math.floor(height)

  -- Create new empty buffer
  local buf = vim.api.nvim_create_buf(false, true)
  -- Create the floating window
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
  })

  -- Start terminal in the floating window
  vim.fn.termopen(vim.o.shell)
end

-- Create the command "FloatTerm" that calls the floating_terminal function
vim.api.nvim_create_user_command('FloatTerm', function()
  floating_terminal()
end, {})

-- Function to run a command in a terminal using termopen in a bottom split
local function run_command_in_terminal(command)
  -- Split the window and open the terminal buffer
  vim.cmd('botright split')
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_current_buf(buf)

  -- Open a terminal in the new buffer and run the command
  vim.fn.termopen(command)
end

-- Function to run a command in a floating terminal using termopen
local function run_command_in_floating_terminal(command)
  -- Define the floating window size and position
  local width = vim.api.nvim_get_option('columns') - 20
  local height = vim.api.nvim_get_option('lines') - 10
  local row = 5
  local col = 10

  -- Ensure width and height are integers
  width = math.floor(width)
  height = math.floor(height)

  -- Create new empty buffer
  local buf = vim.api.nvim_create_buf(false, true)
  -- Create the floating window
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
  })

  -- Open a terminal in the new buffer and run the command
  vim.fn.termopen(command)
end

-- Example specific commands to run commands in a terminal
-- Create the command "Docker" that opens lazydocker in a terminal
vim.api.nvim_create_user_command('Lazydocker', function()
  run_command_in_floating_terminal('lazydocker')
end, {})

-- Create the command "NpmDev" that runs "npm run dev" in a terminal
vim.api.nvim_create_user_command('NpmDev', function()
  run_command_in_terminal('npm run dev')
end, {})
