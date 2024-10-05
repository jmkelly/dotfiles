return {
	"seblj/roslyn.nvim",
	config = function ()
		require('mason').setup({
			registries = {
				'github:mason-org/mason-registry',
				'github:syndim/mason-registry'
			},
		})
	end
}
