return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function ()
      vim.opt.background = "dark"
      vim.cmd([[colorscheme gruvbox]])
    end,
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    cmd = {
      "BufferLineGoToBuffer"
    },
    lazy = false,
    priority = 1000,
    opts = {}
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    lazy = false,
    priority = 1000,
    opts = {
      options = {
        theme = "gruvbox"
      },
      extensions = {
        "lazy",
        "man",
        "mason",
        "quickfix"
      }
    }
  },
  {
    "nvim-treesitter/nvim-treesitter",
    cmd = {
      "TSInstall",
      "TSBufEnable",
      "TSBufDisable",
      "TSModuleInfo"
    },
    build = ":TSUpdate",
    lazy = false,
    priority = 1000,
    opts = {
      ensure_installed = {
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "elixir",
        "heex",
        "javascript",
        "typescript",
        "html"
      },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    }
  }
}
