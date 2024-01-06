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
    cmd = {
      "BufferLineGoToBuffer"
    },
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require("bufferline").setup()
    end,
    lazy = false
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require('lualine').setup({
        options = { theme = 'gruvbox' }
      })
    end
  }
}
