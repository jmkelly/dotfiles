return {
    "stevearc/conform.nvim",
    --dir = "~/Documents/code/conform.nvim",
    --name = "conform.nvim",
    opts = {},
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                cs = {
                    csharpier = {
                        --workaround until https://github.com/stevearc/conform.nvim/pull/695 is merged
                        command = "csharpier",
                        args = "format",
                    },
                },
                sql = { "sqruff" },
            },
            format_after_save = {
                lsp_format = "fallback",
            },
        })
    end,
}
