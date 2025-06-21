local lsp_status_ok, _ = pcall(require, "lspconfig")
if not lsp_status_ok then
    print("LSP configuration failed: nvim-lspconfig not found")
    return
end

local mason_status_ok, mason = pcall(require, "mason")
if not mason_status_ok then
    print("LSP configuration failed: mason.nvim not found")
    return
end

local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status_ok then
    print("LSP configuration failed: mason-lspconfig not found")
    return
end

-- Setup mason
mason.setup({
    ui = {
        border = "rounded",
    }
})

-- Define on_attach function for LSP
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- LSP key mappings
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)

    -- Diagnostics
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, bufopts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, bufopts)
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, bufopts)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, bufopts)
end

-- Setup capabilities (with nvim-cmp if available)
local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_nvim_lsp_status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if cmp_nvim_lsp_status_ok then
    capabilities = cmp_nvim_lsp.default_capabilities()
end

-- Configure diagnostics display
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
})

-- Set up Mason-LSPConfig
mason_lspconfig.setup({
    ensure_installed = { "pyright", "lua_ls" },  -- Add any servers you want automatically installed
    automatic_installation = true,
})

-- Configure LSP servers
mason_lspconfig.setup_handlers({
    -- Default handler for all servers
    function(server_name)
        require("lspconfig")[server_name].setup({
            on_attach = on_attach,
            capabilities = capabilities,
        })
    end,
    
    -- Custom configuration for pyright
    ["pyright"] = function()
        require("lspconfig").pyright.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                python = {
                    analysis = {
                        autoSearchPaths = true,
                        useLibraryCodeForTypes = true,
                        typeCheckingMode = "basic", -- "off", "basic", "strict"
                    },
                },
            },
        })
    end,
    
    -- Custom configuration for lua_ls (for Neovim configuration)
    ["lua_ls"] = function()
        require("lspconfig").lua_ls.setup({
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },  -- Recognize 'vim' as a global
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file("", true),
                        checkThirdParty = false,
                    },
                    telemetry = {
                        enable = false,
                    },
                },
            },
        })
    end,
})

print("LSP configuration loaded successfully.")
