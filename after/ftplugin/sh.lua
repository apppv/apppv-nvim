-- Set options for Bash scripting
vim.bo.tabstop = 4 -- Number of spaces that a <Tab> in the file counts for
vim.bo.shiftwidth = 4 -- Number of spaces to use for each step of (auto)indent
vim.bo.expandtab = true -- Use spaces instead of tabs
vim.bo.autoindent = true -- Copy indent from current line when starting a new line
vim.bo.textwidth = 80 -- Soft wrap lines at 80 characters

vim.cmd([[
  autocmd BufRead,BufNewFile * if getline(1) =~# '^#!.*/env\s\+bash' || getline(1) =~# '^#!.*/bash' || getline(1) =~# '^#!.*/env\s\+sh' || getline(1) =~# '^#!.*/sh' | setfiletype sh | endif
]])

-- Autoformat using shfmt on save
--[[ vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = {"*.sh"},
    callback = function()
        vim.api.nvim_command('%!shfmt -i 2 -ci')
    end
}) ]]

-- Autoformat using beautysh on save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.sh' },
  callback = function()
    -- Replace the current buffer content with the formatted version
    local original_content = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), '\n')
    local formatted_content = vim.fn.system('beautysh -', original_content)
    if vim.v.shell_error == 0 then
      vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(formatted_content, '\n'))
    end
  end,
})

-- vim.filetype.add {
--    pattern = {
--      ["*.env"] = "sh",
--      ["zsh"] = "sh",
--    },
--  }
