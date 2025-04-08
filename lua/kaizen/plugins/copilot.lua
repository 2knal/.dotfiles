return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    lazy = false,
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    opts = {
      show_help = true,
      model = "claude-3.5-sonnet",
      chat_autocomplete = true,
      window = {
        width = 0.4,
      },
      mappings = {
        complete = {
          insert = "<C-Tab>",
        },
      },
    },
    keys = {
      { "<leader>go", "<cmd>CopilotChatOpen<CR>", desc = "Open Copilot Chat" },
      { "<leader>gc", "<cmd>CopilotChatClose<CR>", desc = "Close Copilot Chat" },
      { "<leader>gr", "<cmd>CopilotChatReset<CR>", desc = "Reset Copilot Chat" },
    },
  },
}
