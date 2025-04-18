return {
  {
    "echasnovski/mini.nvim",
    config = function()
      local statusline = require("mini.statusline")
      statusline.setup({ use_icons = true })

      local icons = require("mini.icons")
      icons.setup()

      vim.opt.statusline:append("%p%%")
    end,
  },
}
