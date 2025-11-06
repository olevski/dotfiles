return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      debug = true,
      sources = {
        null_ls.builtins.formatting.gofmt,
        null_ls.builtins.diagnostics.mypy,
        null_ls.builtins.formatting.stylelint,
      },
    })
  end,
  dependencies = { "nvim-lua/plenary.nvim" },
}
