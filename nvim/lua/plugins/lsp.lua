return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    ---@type lspconfig.options
    servers = {
      ["bash-language-server"] = { auto_update = true },
      ["lua-language-server"] = {},
      ["vim-language-server"] = {},
      stylua = {},
      ["editorconfig-checker"] = {},
      luacheck = {},
      misspell = {},
      shellcheck = {},
      shfmt = {},
      vint = {},
      lua_ls = {
        -- cmd = {...},
        -- filetypes = { ...},
        -- capabilities = {},
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
            diagnostics = { globals = { "vim" } },
          },
        },
      },
      -- python
      pyright = {
        filetypes = { "python" },
        -- see https://microsoft.github.io/pyright/#/settings?id=pyright-settings for what is accepted in settings
        settings = {
          python = {
            disableOrganizeImports = true,
            analysis = {
              autoImportCompletions = true,
              typeCheckingMode = "off",
              diagnosticMode = "openFilesOnly",
              useLibraryCodeForTypes = true,
            },
          },
        },
      },
      ruff = { filetypes = { "python" } },
      -- go
      gopls = {},
      templ = { filetypes = { "templ" } },
      -- rust
      rust_analyzer = {},
      -- html
      html = { filetypes = { "html", "twig", "hbs" } },
      cssls = {},
      -- nix
      nil_ls = {},
      -- terraform
      terraformls = { filetypes = { "terraform", "terraform-vars", "hcl" } },
      -- zig
      zls = {},
      -- javascript / typescript
      eslint = {
        on_attach = function(client, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
        end,
        settings = {
          packageManager = "npm",
        },
      },
      ts_ls = {
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
      },
    },
  },
}
