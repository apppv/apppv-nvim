-- Set the correct filetype to stop lsp yelling about comments.
vim.filetype.add({
  extension = {
    mdx = 'markdown',
  },
  filename = {
    ['.prettierrc'] = 'jsonc',
    ['.prettierrc.json'] = 'jsonc',
    ['.eslintrc'] = 'jsonc',
    ['.eslintrc.json'] = 'jsonc',
    ['tsconfig.json'] = 'jsonc',
    ['jsconfig.json'] = 'jsonc',
  },
  pattern = {
    ['[jt]sconfig%.json'] = 'jsonc',
    ['[pP]ackage%.json'] = 'jsonc',
  },
})

-- autocmd BufNewFile,BufRead tsconfig.json setlocal filetype=jsonc
