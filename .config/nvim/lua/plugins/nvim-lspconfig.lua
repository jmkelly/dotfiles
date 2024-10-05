return {
	-- LSP Configuration & Plugins
	'neovim/nvim-lspconfig',
	dependencies = {
		-- Automatically install LSPs to stdpath for neovim
		'williamboman/mason.nvim',
		'williamboman/mason-lspconfig.nvim',
		'seblj/roslyn.nvim',
	},
	config = function()
		-- require 'lspconfig'.omnisharp.setup {
		-- 	enable_roslyn_analyzers = true
		-- }
		--
		require('rosyln').setup()
	end
}
