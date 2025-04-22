return {
  {
    "rmagatti/auto-session",
    lazy = false,
    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      session_lens = {
        mappings = {
          delete_session = { "n", "<C-b>" },
        },
      },
    },
  },
}
