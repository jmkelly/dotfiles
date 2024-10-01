return {
	{
		"williamboman/mason.nvim",
		config = function()
			require('mason').setup()
			require('mason-lspconfig').setup()
			-- require('mason-lspconfig').setup({
			-- 	handlers = {
			-- 		omnisharp = {
			-- 			handlers = {
			-- 				["textDocument/definition"] = require('omnisharp_extended').handler
			-- 			}
			-- 		}
			-- 	}
			-- }
			-- )
		end
	},
	{ "williamboman/mason-lspconfig.nvim" },
	{ "neovim/nvim-lspconfig" }
}
