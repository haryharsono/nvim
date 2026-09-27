-- AstroNvim pins aerial.nvim to the version bundled in its release snapshot
-- (v2.7.0), which predates aerial's Neovim 0.12 compatibility fix
-- (node:start() -> node:range(), released in v4.0.0). Un-pin it so it can
-- track its own releases instead of crashing on every buffer.

---@type LazySpec
return {
  "stevearc/aerial.nvim",
  version = "*",
}
