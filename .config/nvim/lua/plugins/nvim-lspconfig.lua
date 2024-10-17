return {
	-- LSP Configuration & Plugins
	'neovim/nvim-lspconfig',
	dependencies = {
		-- Automatically install LSPs to stdpath for neovim
		'williamboman/mason.nvim',
		'williamboman/mason-lspconfig.nvim',
	},
	config = function(opts)
		-- require 'lspconfig'.omnisharp.setup {
		-- 	enable_roslyn_analyzers = true
		-- }

		require('roslyn').setup(opts)
	end
}
