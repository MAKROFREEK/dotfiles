vim.opt.termguicolors = false
vim.opt.background = "dark"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.laststatus = 2
vim.opt.showmode = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.mouse = "a"
vim.opt.swapfile = false
vim.opt.clipboard = "unnamedplus"

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.cmd("highlight Normal ctermbg=NONE guibg=NONE")
    vim.cmd("highlight LineNr ctermbg=NONE guibg=NONE")
    vim.cmd("highlight SignColumn ctermbg=NONE guibg=NONE")
    vim.cmd("highlight CursorLineNr ctermfg=White guifg=White")
    vim.cmd("highlight StatusLine ctermbg=NONE ctermfg=Gray guibg=NONE guifg=Gray")
    vim.cmd("highlight StatusLineNC ctermbg=NONE ctermfg=Gray guibg=NONE guifg=Gray")
  end,
})

-- vim.cmd("colorscheme unokai")
