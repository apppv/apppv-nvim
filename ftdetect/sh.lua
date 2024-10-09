vim.filetype.add({
  extension = {
    env = 'sh',
    zsh = 'sh',
  },
  filename = {
    [".env"] = "sh",
    [".envrc"] = "sh",
    ["*.env"] = "sh",
    ["*.envrc"] = "sh",
    ['.aliases'] = 'sh',
  },

  pattern = {
    ["^\\.?(?:zsh(?:rc|env|-aliases)?)$"] = "sh",
  },
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*',
  callback = function()
    local first_line = vim.fn.getline(1)
    if
      first_line:match('^#!/usr/bin/env bash')
      or first_line:match('^#!/bin/bash')
      or first_line:match('^#!/usr/bin/bash')
      or first_line:match('^#!/usr/local/bin/bash')
    then
      vim.bo.filetype = 'bash'
      print('Filetype set to bash')
    elseif
      first_line:match('^#!/usr/bin/env sh')
      or first_line:match('^#!/bin/sh')
      or first_line:match('^#!/usr/bin/sh')
      or first_line:match('^#!/usr/local/bin/sh')
    then
      vim.bo.filetype = 'sh'
      print('Filetype set to sh')
    end
  end,
})
