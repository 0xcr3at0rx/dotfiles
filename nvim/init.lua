vim.g.mapleader = " "

vim.opt.mouse = "a"
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

vim.opt.clipboard = "unnamedplus"

-- smooth editing
vim.opt.wrap = false
vim.opt.cursorline = true

-- escape shortcuts
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("i", "jk", "<Esc>")

local number_toggle = vim.api.nvim_create_augroup("NumberToggle", { clear = true })

vim.api.nvim_create_autocmd({ "InsertEnter" }, {
  group = number_toggle,
  callback = function()
    vim.opt.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  group = number_toggle,
  callback = function()
    vim.opt.relativenumber = true
  end,
})

-- =========================
-- PLUGINS (light only)
-- =========================
vim.pack.add({
  { src = "https://github.com/rose-pine/neovim" },
  { src = "https://github.com/numToStr/Comment.nvim" },
  { src = "https://github.com/windwp/nvim-autopairs" },
  { src = "https://github.com/kylechui/nvim-surround" },
})

-- =========================
-- SAFE LOAD (no LSP, no errors)
-- =========================
vim.schedule(function()

  pcall(function()
    require("rose-pine").setup({
      disable_background = true,
      disable_float_background = true,
    })

    vim.o.background = "dark"
    vim.cmd.colorscheme("rose-pine")
  end)

  pcall(function() require("Comment").setup() end)
  pcall(function() require("nvim-autopairs").setup() end)
  pcall(function() require("nvim-surround").setup() end)

end)
