return {
  {
    "nordtheme/vim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function ()
      vim.cmd([[
        colorscheme nord
        highlight Normal guibg=NONE ctermbg=NONE
        highlight NormalNC guibg=NONE ctermbg=NONE
        highlight EndOfBuffer guibg=NONE ctermbg=NONE
        highlight SignColumn guibg=NONE ctermbg=NONE
      ]])
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
