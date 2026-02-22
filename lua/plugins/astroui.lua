-- AstroUI provides the basis for configuring the AstroNvim User Interface
-- Configuration documentation can be found with `:h astroui`

---@type LazySpec
return {
  "AstroNvim/astroui",
  ---@type AstroUIOpts
  opts = {
    -- change colorscheme
    colorscheme = "solarized",
    background = "light",
    -- AstroUI allows you to easily modify highlight groups easily for any and all colorschemes
    highlights = {
      init = { -- this table overrides highlights in all themes
        -- Tabline / Bufferline colors for visibility
        TabLine = { fg = "#657b83", bg = "#eee8d5" },           -- inactive tabs
        TabLineSel = { fg = "#073642", bg = "#fdf6e3", bold = true }, -- active tab
        TabLineFill = { bg = "#eee8d5" },                       -- tabline background
        -- Heirline buffer colors
        HeirlineBufferline = { fg = "#657b83", bg = "#eee8d5" },
        HeirlineBufferlineActive = { fg = "#073642", bg = "#fdf6e3", bold = true },
        HeirlineBufferlineInactive = { fg = "#657b83", bg = "#eee8d5" },
      },
      solarized = { -- solarized theme overrides
        TabLine = { fg = "#657b83", bg = "#eee8d5" },
        TabLineSel = { fg = "#073642", bg = "#fdf6e3", bold = true },
        TabLineFill = { bg = "#eee8d5" },
      },
    },
    -- Icons can be configured throughout the interface
    icons = {
      -- configure the loading of the lsp in the status line
      LSPLoading1 = "⠋",
      LSPLoading2 = "⠙",
      LSPLoading3 = "⠹",
      LSPLoading4 = "⠸",
      LSPLoading5 = "⠼",
      LSPLoading6 = "⠴",
      LSPLoading7 = "⠦",
      LSPLoading8 = "⠧",
      LSPLoading9 = "⠇",
      LSPLoading10 = "⠏",
    },
  },
}
