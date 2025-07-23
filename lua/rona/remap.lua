vim.g.mapleader = " "
vim.keymap.set("n", "<leader>ge", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>p", '"_dP')  -- Paste without overwriting the default register

vim.keymap.set("n", "<leader>y", '"+y')  -- Copy to system clipboard
vim.keymap.set("v", "<leader>y", '"+y')  -- Copy to system clipboard
vim.keymap.set("n", "<leader>Y", '"+Y')  -- Copy to system clipboard (line-wise)

vim.keymap.set("n", "<leader>d", '"_d')  -- Delete without copying to default register
vim.keymap.set("v", "<leader>d", '"_d')  -- Delete without copying to default register

vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format { async = true }
end)  -- Format the current buffer using LSPConfig

vim.keymap.set('n', 'Q', '<nop>')  -- Disable Q in normal mode

vim.keymap.set("n", "<leader>q", ":bd<CR>")  -- Quick quit
vim.keymap.set("n", "<leader>w", ":w<CR>")  -- Quick save
vim.keymap.set("n", "<leader>W", ":wq<CR>")  -- Quick save and quit

vim.keymap.set("n", "tn", ":tabn<CR>")  -- Next tab 
vim.keymap.set("n", "tp", ":tabp<CR>")  -- Previous tab

