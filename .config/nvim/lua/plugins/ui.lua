return {
  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify"
    },
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true
        }
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false
      }
    }
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        config = function()
          require("telescope").load_extension("fzf")
        end
      },
      {
        "nvim-telescope/telescope-file-browser.nvim",
        config = function()
          require("telescope").load_extension("file_browser")
        end
      },
      {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
          require("telescope").load_extension("ui-select")
        end
      }
    },
    cmd = "Telescope",
    config = true,
    keys = function()
      local builtin = require("telescope.builtin")
      return {
        { "<leader>ff", builtin.find_files, desc = "find_files" },
        { "<leader>fg", builtin.live_grep, desc = "live_grep" },
        { "<leader>fb", builtin.buffers, desc = "buffers" },
        { "<leader>fh", builtin.help_tags, desc = "help_tags" },
        { "<leader>pf", ":Telescope file_browser<CR>", desc = "file_browser" },
        { "<leader>pf", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", desc = "file_browser with path"}
      }
    end
  },
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    init = function()
      vim.api.nvim_create_autocmd('BufEnter', {
        desc = 'makes sure any opened buffer inside a git repo will be tracked by lazygit',
        callback = function()
          require('lazygit.utils').project_root_dir()
        end,
        group = vim.api.nvim_create_augroup('Lazygit', { clear = false })
      })
    end,
    config = function()
      require('telescope').load_extension('lazygit')
    end,
    keys = {
      { "<leader>gg", "<cmd>LazyGit<CR>", desc = "LazyGit" },
      { "<leader>gG", "<cmd>Telescope lazygit<CR>", desc = "Telescope Lazygit" }
    }
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    init = function()
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function(data)
          local real_file = vim.fn.filereadable(data.file) == 1

          local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

          if real_file and not no_name then
            return
          end

          require("nvim-tree.api").tree.toggle({ focus = true, find_file = true })
        end
      })
    end,
    opts = {
      sort = {
        sorter = "case_sensitive"
      },
      view = {
        width = 30
      },
      renderer = {
        group_empty = true
      },
      filters = {
        dotfiles = true
      },
      update_focused_file = {
        enable = true,
        update_cwd = true
      }
    }
  },
  {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm" },
    config = true,
    keys = {
      { "<leader>tt", "<cmd>ToggleTerm<CR>", desc = "ToggleTerm" }
    }
  }
}
