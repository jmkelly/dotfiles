return {
	"seblj/roslyn.nvim",
    ft = "cs",
	config = function ()
		require('mason').setup({
			registries = {
				'github:mason-org/mason-registry',
				'github:syndim/mason-registry'
			},
		})
	end
}
