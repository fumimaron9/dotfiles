return {
  {
    "akinsho/bufferline.nvim",
    cmd = {
      "BufferLineGoToBuffer"
    },
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require("bufferline").setup({
        options = {
          separator_style = { "", "" },
          bruh = false,
          tab_size = 22,
          enforce_regular_tabs = true,
          view = "multiwindow",
          show_buffer_close_icons = true,
          diagnostics = "nvim_lsp",
          always_show_bufferline = true
        },
      })
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
        theme = 'papercolor_light'
      })
    end
  }
}
