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

vim.opt.scrolloff = 30  -- Keep 30 lines above/below the cursor
vim.opt.signcolumn = "yes"  -- Always show the sign column

vim.opt.isfname:append("@-@")  -- Allow '@' in file names
vim.opt.updatetime = 50 

vim.opt.colorcolumn = "80"  -- Highlight column 80

vim.opt.ignorecase = true  -- Ignore case in search patterns
vim.opt.smartcase = true  -- Override ignorecase if search pattern contains uppercase letters

-- Highlight all occurrences of the word under cursor
vim.api.nvim_create_augroup("CursorWordHighlight", { clear = true })
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    group = "CursorWordHighlight",
    callback = function()
        -- Clear previous highlights
        vim.cmd([[silent! call clearmatches()]])

        -- Get the word under cursor
        local word = vim.fn.expand("<cword>")

        -- Only highlight if the word is not empty and is a valid identifier
        if word ~= "" and word:match("^[%w_]+$") then
            -- Highlight all occurrences of the word
            vim.fn.matchadd("CursorWordHighlight", [[\<]] .. word .. [[\>]])
        end
    end,
})

-- Define the highlight group for the word under cursor
vim.api.nvim_set_hl(0, "CursorWordHighlight", {
    bg = "#3d3d3d",
    underline = true
})
