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
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    priority = 1000,
    opts = function()
      return {
        options = {
          theme = "auto"
        },
        extensions = {
          "lazy",
          "man",
          "mason",
          "quickfix"
        },
        lualine_x = {
          {
            require("noice").api.status.message.get_hl,
            cond = require("noice").api.status.message.has
          },
          {
            require("noice").api.status.command.get,
            cond = require("noice").api.status.command.has,
            color = { fg = "#ff9e64" }
          },
          {
            require("noice").api.status.mode.get,
            cond = require("noice").api.status.mode.has,
            color = { fg = "#ff9e64" }
          },
          {
            require("noice").api.status.search.get,
            cond = require("noice").api.status.search.has,
            color = { fg = "#ff9e64" }
          }
        }
      }
    end,
    config = function(_, opts)
      require("lualine").setup(opts)
      require("telescope").load_extension("noice")
    end,
    keys = {
      { "<leader>nl", '<cmd>lua require("noice").cmd("last")<CR>', desc = "noice last" },
      { "<leader>nh", '<cmd>lua require("noice").cmd("history")<CR>', desc = "noice history" },
      { "<S-Enter>", '<cmd>lua require("noice").redirect(vim.fn.getcmdline())<CR>', mode = "c", desc = "Redirect Cmdline" },
      { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward" },
      { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward"},
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
        { "<leader>gs", builtin.git_status, desc = "git_status" },
        { "<leader>pf", "<cmd>Telescope file_browser<CR>", desc = "file_browser" },
        { "<leader>pf", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>", desc = "file_browser with path"},
      }
    end
  },
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    init = function()
      vim.api.nvim_create_autocmd("BufEnter", {
        desc = "makes sure any opened buffer inside a git repo will be tracked by lazygit",
        callback = function()
          require("lazygit.utils").project_root_dir()
        end,
        group = vim.api.nvim_create_augroup("Lazygit", { clear = false })
      })
    end,
    config = function()
      require("telescope").load_extension("lazygit")
    end,
    keys = {
      { "<leader>gg", "<cmd>LazyGit<CR>", desc = "LazyGit" },
      { "<leader>gG", "<cmd>Telescope lazygit<CR>", desc = "Telescope Lazygit" }
    },
    enabled = false
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    init = function()
      vim.api.nvim_create_autocmd("VimEnter", {
        desc = "filer opens when file argument does not exist",
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
