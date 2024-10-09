vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = {
    '.gitlab-ci.{yml,yaml}',
    '*.gitlab-ci.{yml,yaml}',
    'gitlab.{yml,yaml}',
  },
  callback = function()
    vim.bo.filetype = 'yaml.gitlab'
  end,
})
