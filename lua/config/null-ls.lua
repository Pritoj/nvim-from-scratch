local null_ls = require("null-ls")

null_ls.setup {
  sources = {
    null_ls.builtins.completion.spell,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.prettierd,
    require("none-ls.formatting.jq"),
    require("none-ls.code_actions.eslint_d"),
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.code_actions.ts_node_action,
  }
}
