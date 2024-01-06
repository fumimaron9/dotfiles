return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function ()
      require("gruvbox").setup()
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
    config = function()
      require("bufferline").setup()
    end
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require("lualine").setup({
        options = {
          theme = "gruvbox"
        }
      })
    end
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
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "typescript", "html" },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      })
    end
  }
}
