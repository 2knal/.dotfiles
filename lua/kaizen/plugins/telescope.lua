return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "BurntSushi/ripgrep",
      "sharkdp/fd",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-tree/nvim-web-devicons",
      "nvim-telescope/telescope-ui-select.nvim",
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        version = "^1.0.0",
      },
    },
    config = function()
      local builtin = require("telescope.builtin")
      local custom_search_path = nil

      local function find_files_with_path()
        builtin.find_files({
          prompt_title = (
            custom_search_path and ("Search Files in " .. vim.fn.fnamemodify(custom_search_path, ":~"))
            or "Search Files"
          ) .. " (Ctrl-s: Set Dir, Ctrl-b: Clear Dir)",
          cwd = custom_search_path,
          attach_mappings = function(prompt_bufnr, _)
            local actions = require("telescope.actions")
            local action_state = require("telescope.actions.state")

            vim.keymap.set("i", "<C-s>", function()
              actions.close(prompt_bufnr)

              builtin.find_files({
                attach_mappings = function(dir_prompt_bufnr)
                  actions.select_default:replace(function()
                    local selection = action_state.get_selected_entry()
                    actions.close(dir_prompt_bufnr)
                    if selection then
                      custom_search_path = vim.fn.fnamemodify(selection.path, ":p:h")
                      vim.notify("Search path set to " .. custom_search_path)
                      find_files_with_path()
                    end
                  end)
                  return true
                end,
                prompt_title = "Search directory for search scope (select any file in target directory)",
              })
            end, { buffer = prompt_bufnr })

            vim.keymap.set("i", "<C-b>", function()
              custom_search_path = nil
              vim.notify("Search path cleared")
              actions.close(prompt_bufnr)
              find_files_with_path()
            end, { buffer = prompt_bufnr })

            return true
          end,
        })
      end

      vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
      vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
      vim.keymap.set("n", "<leader>sf", find_files_with_path, { desc = "[S]earch [F]iles" })
      vim.keymap.set("n", "<leader>sF", builtin.git_files, { desc = "[S]earch [G]it [F]iles" })
      vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
      vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
      vim.keymap.set(
        "n",
        "<leader>sg",
        ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
        { desc = "[S]earch by [G]rep" }
      )
      vim.keymap.set("n", "<leader>sd", function()
        builtin.diagnostics({ bufnr = 0 })
      end, { desc = "[S]earch current file [d]iagnostics" })
      vim.keymap.set("n", "<leader>sD", builtin.diagnostics, { desc = "[S]earch global [D]iagnostics" })
      vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
      vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set("n", "<leader>sn", function()
        builtin.find_files({ cwd = vim.fn.stdpath("config") })
      end, { desc = "[S]earch [N]eovim files" })

      -- Open telescope selection in a new tab
      local actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          file_ignore_patterns = { "node_modules" },
          generic_sorter = function(opts)
            local sorter = require("telescope.sorters").get_generic_fuzzy_sorter(opts)
            -- Modify generic sorter to prioritize subsequence matches
            sorter.scoring_function = function(_, prompt, line)
              local score = vim.fn.matchstrpos(line:lower(), prompt:lower())
              if score[1] == -1 then
                return 999999
              end
              return score[2]
            end
            return sorter
          end,
          mappings = {
            i = {
              -- Map `<C-t>` to open the selected file in a new tab
              ["<C-t>"] = actions.file_tab,
              ["<C-h>"] = actions.select_vertical,
            },
            n = {
              -- Map `<C-t>` to open the selected file in a new tab (in normal mode)
              ["<C-t>"] = actions.file_tab,
              ["<C-h>"] = actions.select_vertical,
            },
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      -- To get ui-select loaded and working with telescope, you need to call
      -- load_extension, somewhere after setup function:
      require("telescope").load_extension("ui-select")
      require("telescope").load_extension("live_grep_args")
    end,
  },
}
