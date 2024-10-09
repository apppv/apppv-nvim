-- ========================================================
--  Template Auto-insertion for New Files in Neovim
-- ========================================================

-- [[ Set up the path to the templates directory ]]
local templates_dir = vim.fn.stdpath('config') .. '/templates/'

-- ========================================================
--  Function: Insert Template
--  Automatically inserts a template when a new file is created
--  Arguments:
--    - extension: The file extension or pattern to match
--    - template_file: The template file to insert
-- ========================================================
local function insert_template(extension, template_file)
  vim.api.nvim_create_autocmd('BufNewFile', {
    pattern = extension,
    callback = function()
      vim.cmd('0r ' .. templates_dir .. template_file)
    end,
  })
end

-- ========================================================
--  Template Auto-insertion Setup for Various File Types
-- ========================================================

-- Python files
insert_template('*.py', 'template.py')

-- Ruby files
insert_template('*.rb', 'template.rb')

-- Shell script files
insert_template('*.sh', 'template.sh')

-- HTML files (specifically index.html)
insert_template('index.html', 'template_index.html')

-- ========================================================
--  Extend Here for Future File Types
--  To add a new template, call `insert_template` with:
--    - file extension or pattern
--    - corresponding template file
-- ========================================================
-- Example:
-- insert_template("*.js", "template.js")
-- insert_template("*.cpp", "template.cpp")
