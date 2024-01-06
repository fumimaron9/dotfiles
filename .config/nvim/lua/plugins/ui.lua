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
    lazy = false,
    config = function()
      require("nvim-tree").setup({
        sort = {
          sorter = "case_sensitive",
        },
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = true,
        },
      })

      local function open_nvim_tree(data)
        local real_file = vim.fn.filereadable(data.file) == 1

        -- buffer is a [No Name]
        local no_name = data.file == "" and vim.bo[data.buf].buftype == ""

        if real_file and not no_name then
          return
        end

        require("nvim-tree.api").tree.toggle({ focus = true, find_file = true, })
      end

      vim.api.nvim_create_autocmd('VimEnter', { callback = open_nvim_tree })
    end
  }
}
