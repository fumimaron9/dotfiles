return {
  {
    "nvim-tree/nvim-tree.lua",
    cmd = {
      "NvimTreeToggle",
      "NvimTreeFocus"
    },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup()
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
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "typescript", "html" },
        sync_install = false,
        highlight = { enable = false },
        indent = { enable = true },
      })
    end
  }
}
