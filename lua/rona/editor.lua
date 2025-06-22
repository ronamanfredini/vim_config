-- Enable relative line numbers
vim.opt.relativenumber = true
-- Enable absolute line numbers
vim.opt.number = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true  -- Use spaces instead of tabs

vim.opt.smartindent = true  -- Enable smart indentation
vim.opt.wrap = false  -- Disable line wrapping

vim.opt.swapfile = false  -- Disable swap files
vim.opt.backup = false  -- Disable backup files
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"  -- Set undo directory
vim.opt.undofile = true  -- Enable persistent undo

vim.opt.termguicolors = true

vim.opt.hlsearch = false-- Highlight search results
vim.opt.incsearch = true  -- Incremental search

vim.opt.scrolloff = 8  -- Keep 8 lines above/below the cursor
vim.opt.signcolumn = "yes"  -- Always show the sign column

vim.opt.isfname:append("@-@")  -- Allow '@' in file names
vim.opt.updatetime = 50 

vim.opt.colorcolumn = "80"  -- Highlight column 80
