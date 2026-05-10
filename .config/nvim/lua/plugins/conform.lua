return {
    "stevearc/conform.nvim",
    --dir = "~/Documents/code/conform.nvim",
    --name = "conform.nvim",
    opts = {},
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                cs = { "csharpier" },
                sql = { "sqruff" },
            },
            format_after_save = {
                lsp_format = "fallback",
            },
        })
    end,
}
