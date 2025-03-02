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
    config = true
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp"
    },
    cmd = {
      "LspInstall",
      "LspUninstall"
    },
    lazy = false,
    init = function()
      -- Global mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
      vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

      -- Use LspAttach autocommand to only map the following keys
      -- after the language server attaches to the current buffer

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

          -- Buffer local mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set("n", "<leader>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<leader>f", function()
            vim.lsp.buf.format { async = true }
          end, opts)
        end
      })
    end,
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "dockerls",
          "docker_compose_language_service",
          "gopls",
          "lua_ls",
          "vtsls"
        }
      })

      require("mason-lspconfig").setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
            on_attach = function(client)
              if client.name == "gopls" then
                if not client.server_capabilities.semanticTokensProvider then
                  local semantic = client.config.capabilities.textDocument.semanticTokens
                  client.server_capabilities.semanticTokensProvider = {
                    full = true,
                    legend = {
                      tokenTypes = semantic.tokenTypes,
                      tokenModifiers = semantic.tokenModifiers,
                    },
                    range = true,
                  }
                end
              end
            end
          })
        end
      })

      vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics,
        {
          virtual_text = {
            format = function(diagnostic)
              return string.format("%s (%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
            end
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
    opts = {
      ensure_installed = {
        "prettier",
        "stylua",
        "eslint_d",
        "golangci_lint",
        "gofumpt",
        "terraform_fmt",
        "terraform_validate",
        "shellcheck",
        "beautysh",
        "yamllint",
        "yamlfmt",
        "buf"
      }
    }
  },
  {
    "nvim-treesitter/nvim-treesitter",
    enabeld = false,
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
        "markdown_inline",
        "go",
        "gomod",
        "gowork",
        "gosum",
        "terraform",
        "hcl"
      },
      sync_install = false,
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true }
    }
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    event = "LspAttach"
  },
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
      "hrsh7th/cmp-nvim-lsp"
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
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
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
            before = function (_, vim_item)
              return vim_item
            end
          })
        }
      })

      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "git" }
        }, {
          { name = "buffer" }
        })
      })

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "nvim_lsp_document_symbol" }
        }, {
          { name = "buffer" }
        }
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" }
        }, {
          { name = "cmdline" }
        })
      })
    end
  },
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = true
  },
  {
    "onsails/diaglist.nvim",
    event = {
      "User LspDiagnosticsChanged",
      "WinEnter",
      "BufEnter"
    },
    config = function()
      require("diaglist").init({})
    end,
    keys = {
      { "<leader>dw", '<cmd>lua require("diaglist").open_all_diagnostics()<CR>', desc = "open_all_diagnostics" },
      { "<leader>d0", '<cmd>lua require("diaglist").open_buffer_diagnostics()<CR>', desc = "open_buffer_diagnostics" }
    }
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = true
  },
  {
    "brenoprata10/nvim-highlight-colors",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      enable_tailwind = true
    }
  }
  --"mfussenegger/nvim-lint"
  --"stevearc/conform.nvim"
  --"JoosepAlviste/nvim-ts-context-commentstring",
  --"windwp/nvim-ts-autotag",
  --"sindrets/diffview.nvim",
  --"github/copilot.vim"
}
