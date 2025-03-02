return {
  {
    "nordtheme/vim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function ()
      vim.cmd([[colorscheme nord]])
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
}
