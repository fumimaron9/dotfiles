return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function (_, opts)
      require("gruvbox").setup(opts)

      vim.opt.background = "dark"
      vim.cmd([[colorscheme gruvbox]])
    end,
  },
  {
    "akinsho/bufferline.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    lazy = false,
    priority = 1000,
    config = true
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
        theme = "auto"
      },
      extensions = {
        "lazy",
        "man",
        "mason",
        "quickfix"
      }
    }
  }
}
