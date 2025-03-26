print("nvim init")

-- [[ Globals ]]

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("kaizen.set")
require("kaizen.remap")
require("kaizen.autocmd")
require("kaizen.lazy")
