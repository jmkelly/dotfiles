return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				cs = { "csharpier" },
			},
			format_after_save = {
				lsp_format = "fallback",
			},
		})
	end,
}
