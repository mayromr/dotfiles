vim.b.completion = true

vim.keymap.set('i', '<C-n>', function()
  require('dap.repl').on_down()
end)
vim.keymap.set('i', '<C-p>', function()
  require('dap.repl').on_up()
end)
