---@type LazySpec
return {
  "RRethy/vim-illuminate",
  opts = {
    -- treesitter provider crashes against current nvim-treesitter (master rewrite
    -- broke `locals.lua`'s containing_scope: node:parent() called on a non-TSNode)
    -- lsp + regex cover reference highlighting without it
    providers = { "lsp", "regex" },
  },
}
