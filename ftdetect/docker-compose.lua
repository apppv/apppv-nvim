vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = {
    'compose.yml',
    'compose.yaml',
    'docker-compose.yml',
    'docker-compose.yaml',
  },
  callback = function()
    vim.bo.filetype = 'yaml.docker-compose'
  end,
})
