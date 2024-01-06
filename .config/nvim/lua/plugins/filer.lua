return {
  {
    'nvim-tree/nvim-tree.lua',
    cmd = {
      "NvimTreeToggle",
      "NvimTreeFocus"
    },
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require("nvim-tree").setup({
        open_on_setup_file = true
      })
    end
  }
}
