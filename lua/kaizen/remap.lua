-- [[ Keymaps ]]

vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<leader>x", ":.lua<CR>")
vim.keymap.set("v", "<leader>x", ":lua<CR>")
vim.keymap.set("n", "<leader>l", ":Lazy<CR>")
vim.keymap.set("n", "<leader>m", ":Mason<CR>")

local user_grp = vim.api.nvim_create_augroup("LazyUserGroup", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lazy",
  desc = "Quit lazy with <esc>",
  callback = function()
    vim.keymap.set("n", "<esc>", function()
      vim.api.nvim_win_close(0, false)
    end, { buffer = true, nowait = true })
  end,
  group = user_grp,
})

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
local toggle_diagnostics = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local diagnostics_enabled = vim.diagnostic.is_enabled({ bufnr = bufnr })

  if diagnostics_enabled then
    vim.diagnostic.disable(bufnr)
    print("Diagnostics disabled for this buffer")
  else
    vim.diagnostic.enable(bufnr)
    print("Diagnostics enabled for this buffer")
  end
end

vim.keymap.set("n", "<leader>td", toggle_diagnostics, { desc = "[T]oggle [D]iagnostics for each file" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Open diagnostic (float)" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to Next Diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to Prev Diagnostic" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<leader>wc", ":q<CR>", { desc = "Close window" })
vim.keymap.set("n", "<leader>wC", ":q!<CR>", { desc = "Force close window" })
vim.keymap.set("n", "<leader>wo", ":only<CR>", { desc = "Close other windows" })
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- [[ Buffer ]]
vim.keymap.set("n", "<leader>bc", ":bd<CR>", { desc = "Close buffer" })
vim.keymap.set("n", "<leader>bC", ":bd!<CR>", { desc = "Force close buffer" })
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprev<CR>", { desc = "Previous buffer" })

-- [[ Tabs ]]
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", { desc = "Close tab" })
vim.keymap.set("n", "<leader>tn", ":tabnext<CR>", { desc = "Next tab" })
vim.keymap.set("n", "<leader>tp", ":tabprev<CR>", { desc = "Previous tab" })
vim.keymap.set("n", "<leader>tt", ":tabnew<CR>", { desc = "New tab" })

-- [[ Quickfix List ]]
vim.keymap.set("n", "<leader>co", ":copen<CR>", { desc = "Open Quickfix list" })
vim.keymap.set("n", "<leader>cc", ":cclose<CR>", { desc = "Close Quickfix list" })
vim.keymap.set("n", "<leader>cn", ":cnext<CR>", { desc = "Next option in the Quickfix list" })
vim.keymap.set("n", "<leader>cp", ":cprev<CR>", { desc = "Prev option in the Quickfix list" })

-- [[ Location List ]]
vim.keymap.set("n", "<leader>lc", ":lclose<CR>", { desc = "Close Location list" })
vim.keymap.set("n", "<leader>ln", ":lnext<CR>", { desc = "Next option in the Location list" })
vim.keymap.set("n", "<leader>lp", ":lprev<CR>", { desc = "Prev option in the Location list" })
