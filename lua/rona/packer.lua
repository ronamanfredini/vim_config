-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		-- or                            , branch = '0.1.x',

		requires = { {'nvim-lua/plenary.nvim'} }
	}
	use 'https://github.com/github/copilot.vim'
	use ('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
	use 'rose-pine/neovim'
	
	-- LSP
	use 'neovim/nvim-lspconfig'           -- Collection of common configurations for the Nvim LSP client
	use 'williamboman/mason.nvim'          -- Portable package manager for Neovim
	use 'williamboman/mason-lspconfig.nvim' -- Bridges mason.nvim with nvim-lspconfig
	
	-- Autocompletion (optional but recommended)
	use 'hrsh7th/nvim-cmp'         -- Completion framework
	use 'hrsh7th/cmp-nvim-lsp'     -- LSP completion source for nvim-cmp
	use 'hrsh7th/cmp-buffer'       -- Buffer completions
	use 'hrsh7th/cmp-path'         -- Path completions
	use 'L3MON4D3/LuaSnip'         -- Snippet engine
	use 'saadparwaiz1/cmp_luasnip' -- Luasnip completion source
end)
