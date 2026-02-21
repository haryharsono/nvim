local lombok_path = vim.fn.stdpath "config" .. "/lombok.jar"
local jdtls_path = vim.fn.stdpath "data" .. "/mason/packages/jdtls"
local config_path = vim.fn.stdpath "cache" .. "/jdtls/config"
local mason_path = vim.fn.stdpath "data" .. "/mason/packages"

local root_markers = { "gradlew", "mvnw", ".git", "pom.xml", "build.gradle" }
local root_file = vim.fs.find(root_markers, { upward = true })[1]
local root_dir = root_file and vim.fs.dirname(root_file) or vim.fn.getcwd()
local project_name = vim.fn.fnamemodify(root_dir, ":t")
local workspace_path = vim.fn.stdpath "cache" .. "/jdtls/workspace/" .. project_name

-- Debug bundles
local bundles = {}
local java_debug_path = mason_path .. "/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"
local java_debug_bundle = vim.fn.glob(java_debug_path, true)
if java_debug_bundle ~= "" then
  table.insert(bundles, java_debug_bundle)
end

local java_test_path = mason_path .. "/java-test/extension/server/*.jar"
local java_test_bundles = vim.split(vim.fn.glob(java_test_path, true), "\n")
for _, bundle in ipairs(java_test_bundles) do
  if bundle ~= "" then
    table.insert(bundles, bundle)
  end
end

local config = {
  cmd = {
    jdtls_path .. "/bin/jdtls",
    "--jvm-arg=-javaagent:" .. lombok_path,
    "-configuration", config_path,
    "-data", workspace_path,
  },
  root_dir = root_dir,
  settings = {
    java = {
      signatureHelp = { enabled = true },
      contentProvider = { preferred = "fernflower" },
      completion = {
        favoriteStaticMembers = {
          "org.junit.Assert.*",
          "org.junit.Assume.*",
          "org.junit.jupiter.api.Assertions.*",
          "org.mockito.Mockito.*",
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
    },
  },
  init_options = {
    bundles = bundles,
  },
  on_attach = function(client, bufnr)
    require("jdtls").setup_dap { hotcodereplace = "auto" }
    require("jdtls.dap").setup_dap_main_class_configs()
  end,
}

require("jdtls").start_or_attach(config)
