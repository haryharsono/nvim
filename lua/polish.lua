-- This will run last in the setup process.

local function get_comment_style(filetype)
  local styles = {
    lua = { start = "--", mid = "--", ending = "--" },
    java = { start = "/**", mid = " *", ending = " */" },
    javascript = { start = "/**", mid = " *", ending = " */" },
    typescript = { start = "/**", mid = " *", ending = " */" },
    python = { start = '"""', mid = "", ending = '"""' },
    sh = { start = "#", mid = "#", ending = "#" },
    bash = { start = "#", mid = "#", ending = "#" },
    zsh = { start = "#", mid = "#", ending = "#" },
    c = { start = "/**", mid = " *", ending = " */" },
    cpp = { start = "/**", mid = " *", ending = " */" },
    go = { start = "/**", mid = " *", ending = " */" },
    rust = { start = "/**", mid = " *", ending = " */" },
    html = { start = "<!--", mid = "", ending = "-->" },
    css = { start = "/**", mid = " *", ending = " */" },
    sql = { start = "--", mid = "--", ending = "--" },
    yaml = { start = "#", mid = "#", ending = "#" },
    toml = { start = "#", mid = "#", ending = "#" },
  }
  return styles[filetype] or { start = "//", mid = "//", ending = "//" }
end

local function insert_header()
  -- Only insert if file is empty
  if vim.fn.line("$") ~= 1 or vim.fn.getline(1) ~= "" then return end

  local filetype = vim.bo.filetype
  local style = get_comment_style(filetype)
  local filename = vim.fn.expand("%:t")
  local date = os.date("%Y-%m-%d")

  local header = {}

  if filetype == "python" then
    header = {
      style.start,
      "File: " .. filename,
      "Created by: hary",
      "Author: haryharsono",
      "Date: " .. date,
      "Description: ",
      style.ending,
      "",
    }
  elseif style.start == style.mid then
    -- Single line comment style (lua, sh, sql, etc.)
    header = {
      style.start .. " File: " .. filename,
      style.mid .. " Created by: hary",
      style.mid .. " Author: haryharsono",
      style.mid .. " Date: " .. date,
      style.mid .. " Description: ",
      "",
    }
  else
    -- Block comment style (java, js, c, etc.)
    header = {
      style.start,
      style.mid .. " File: " .. filename,
      style.mid .. " Created by: hary",
      style.mid .. " Author: haryharsono",
      style.mid .. " Date: " .. date,
      style.mid .. " Description: ",
      style.ending,
      "",
    }
  end

  vim.api.nvim_buf_set_lines(0, 0, 0, false, header)
  -- Move cursor to Description line
  vim.api.nvim_win_set_cursor(0, { #header - 1, 0 })
  vim.cmd("startinsert!")
end

vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*",
  callback = function()
    -- Delay to let filetype detection happen
    vim.defer_fn(insert_header, 10)
  end,
})
