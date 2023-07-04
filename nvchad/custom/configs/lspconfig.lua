local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "clangd", "omnisharp" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- 
-- lspconfig.pyright.setup { blabla}
lspconfig.omnisharp.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  enable_rosyln_analyzers = true,
  enable_import_completions = true,
  analyze_open_documents_only = true,
  cmd = { "/home/james/.local/share/nvim/mason/bin/omnisharp" }
}

--proper lsp support for omnisharp?
-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function(ev)
--     local client = vim.lsp.get_client_by_id(ev.data.client_id)
--     local function toSnakeCase(str)
--       return string.gsub(str, "%s*[- ]%s*", "_")
--     end
--
--     if client.name == 'omnisharp' then
--       local tokenModifiers = client.server_capabilities.semanticTokensProvider.legend.tokenModifiers
--       for i, v in ipairs(tokenModifiers) do
--         tokenModifiers[i] = toSnakeCase(v)
--       end
--       local tokenTypes = client.server_capabilities.semanticTokensProvider.legend.tokenTypes
--       for i, v in ipairs(tokenTypes) do
--         tokenTypes[i] = toSnakeCase(v)
--       end
--     end
--   end,
-- })
