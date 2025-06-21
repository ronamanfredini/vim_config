-- Check if LSP is available
local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    print("WARNING: lspconfig is not available")
    return
end

-- This file is loaded after the LSP configuration in lua/rona/lsp.lua
-- You can add any additional LSP settings or overrides here

-- Enable diagnostic signs in the gutter
local signs = {
    { name = "DiagnosticSignError", text = "✘" },
    { name = "DiagnosticSignWarn", text = "▲" },
    { name = "DiagnosticSignHint", text = "⚑" },
    { name = "DiagnosticSignInfo", text = "ℹ" },
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

-- You can add any custom LSP-specific commands or settings below
print("Additional LSP settings loaded successfully.")
