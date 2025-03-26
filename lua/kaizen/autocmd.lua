-- [[ Commands ]] 

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("VimLeave", {
  desc = "Reset cursor",
  group = vim.api.nvim_create_augroup("kickstart-cursor-reset", { clear = true }),
  callback = function()
    vim.opt.guicursor = 'a:ver25-blinkwait100-blinkon150-blinkoff100' 
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  desc = "Terminal configurations",
  group = vim.api.nvim_create_augroup("kickstart-term-config", { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

