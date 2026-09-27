; Overrides nvim-treesitter's bundled query: the `#set-lang-from-info-string!`
; custom directive crashes under Neovim 0.12's treesitter query engine
; (node:range() on a nil value) — see
; https://github.com/nvim-treesitter/nvim-treesitter/issues/8618
; Use the plain `@injection.language` capture instead, as Neovim core's own
; bundled query does.

(fenced_code_block
  (info_string
    (language) @injection.language)
  (code_fence_content) @injection.content)

((html_block) @injection.content
  (#set! injection.language "html")
  (#set! injection.combined)
  (#set! injection.include-children))

((minus_metadata) @injection.content
  (#set! injection.language "yaml")
  (#offset! @injection.content 1 0 -1 0)
  (#set! injection.include-children))

((plus_metadata) @injection.content
  (#set! injection.language "toml")
  (#offset! @injection.content 1 0 -1 0)
  (#set! injection.include-children))

([
  (inline)
  (pipe_table_cell)
] @injection.content
  (#set! injection.language "markdown_inline"))
