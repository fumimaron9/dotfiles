return {
  {
    "williamboman/mason.nvim",
    event = "User FileOpened",
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonLog"
    },
    build = ":MasonUpdate",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
      "cmp-nvim-lsp"
    },
    cmd = {
      "LspInstall",
      "LspUninstall"
    },
    lazy = false,
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "dockerls",
          "docker_compose_language_service",
          "gopls",
          "lua_ls",
          "vtsls"
        },
      })

      require("mason-lspconfig").setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = require("cmp_nvim_lsp").default_capabilities()
          })
        end
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(_)
          vim.keymap.set('n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>')
          vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
          vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
          vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
          vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
          vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
          vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
          vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
          vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
          vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
          vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
          vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
        end
      })

      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        {
          virtual_text = {
            format = function(diagnostic)
              return string.format("%s (%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
            end,
          }
        }
      )
    end
  },
  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      { "nvimtools/none-ls.nvim", event = { "BufReadPre", "BufNewFile" }, opts = { diagnostics_format = "#{m} (#{s}: #{c})" } }
    },
    event = {
      "BufReadPre",
      "BufNewFile"
    },
    config = function()
      require("mason-null-ls").setup({
        ensure_installed = {
          "prettier", -- prettier formatter
          "stylua", -- lua formatter
          "eslint_d", -- js linter
          "golangci_lint", -- go linter
          "terraform_fmt", -- terraform formatter
          "terraform_validate", -- terraform linter
          "shellcheck", -- shell linter
          "yamllint", -- yaml linter
          "buf", -- buf formatter
          "beautysh", -- shell formatter
          "gofumpt", -- go formatter
          "yamlfmt", -- yaml formatter
          "spell", -- spell checker
        },
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
        "html",
        "regex",
        "bash",
        "markdown",
        "markdown_inline"
      },
      sync_install = false,
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    }
  },
  { "hrsh7th/cmp-nvim-lsp", event = "LspAttach" },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "hrsh7th/cmp-buffer", event = "InsertEnter" },
      { "hrsh7th/cmp-path", event = "InsertEnter" },
      { "hrsh7th/cmp-cmdline", event = "ModeChanged" },
      { "hrsh7th/cmp-nvim-lsp-signature-help", event = "LspAttach" },
      { "hrsh7th/cmp-nvim-lsp-document-symbol", event = "LspAttach" },
      { "hrsh7th/cmp-calc", event = "InsertEnter" },
      { "hrsh7th/cmp-vsnip", event = "InsertEnter" },
      { "hrsh7th/vim-vsnip", event = "InsertEnter" },
      { "hrsh7th/vim-vsnip-integ", event = "InsertEnter" },
      { "petertriho/cmp-git", dependencies = { "nvim-lua/plenary.nvim" }, event = "InsertEnter", opts = {} },
      { "onsails/lspkind.nvim", event = "LspAttach" },
      { "rafamadriz/friendly-snippets", event = "InsertEnter" },
      "cmp-nvim-lsp"
    },
    event = {
      "InsertEnter",
      "CmdlineEnter"
    },
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")

      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "vsnip" },
          { name = "nvim_lsp_signature_help" },
          { name = "calc" },
          { name = "git" }
        }, {
          { name = "buffer" }
        }),
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text", -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                           -- can also be a function to dynamically calculate max width such as
                           -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
            ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function (entry, vim_item)
              return vim_item
            end
          })
        }
      })

      -- Set configuration for specific filetype.
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = "git" }
        }, {
          { name = "buffer" }
        })
      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "nvim_lsp_document_symbol" }
        }, {
          { name = "buffer" }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" }
        }, {
          { name = "cmdline" }
        })
      })

      vim.cmd("let g:vsnip_filetypes = {}")
    end
  },
  {
    "onsails/diaglist.nvim",
    event = {
      "User LspDiagnosticsChanged",
      "WinEnter",
      "BufEnter"
    },
    config = function()
      require("diaglist").init()

      vim.keymap.set("n", "<leader>dw", "<cmd>lua require('diaglist').open_all_diagnostics()<CR>")
      vim.keymap.set("n", "<leader>d0", "<cmd>lua require('diaglist').open_buffer_diagnostics()<CR>")
    end
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {}
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {}
  },
  {
    "brenoprata10/nvim-highlight-colors",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      enable_tailwind = true
    }
  }
  --"nvim-ts-autotag",
  --"neogit",
  --"diffview.nvim",
  --"git-messenger.vim"
}
