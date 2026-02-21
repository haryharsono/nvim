---@type LazySpec
return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    -- Disable jdtls from being auto-started by lspconfig
    -- We use nvim-jdtls via ftplugin/java.lua instead
    handlers = {
      jdtls = false,
      java_language_server = false,
    },
  },
}
