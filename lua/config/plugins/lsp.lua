local attachListener = function()
	vim.api.nvim_create_autocmd('LspAttach', {
		callback = function(args)
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			if not client then return end
			if client:supports_method('textDocument/formatting') then
				-- Format the current buffer on savelsp
				vim.api.nvim_create_autocmd('BufWritePre', {
					buffer = args.buf,
					callback = function()
						vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
					end,
				})
			end
		end,
	})
end


return {
	{
		"neovim/nvim-lspconfig",
		dependencies = { -- using for completing
			"saghen/blink.cmp",
			{
				"folke/lazydev.nvim",
				opts = {
					library = {
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
			require("lspconfig").lua_ls.setup({ capabilities = capabilities })
			require("lspconfig").gopls.setup({ capabilities = capabilities })
			require("lspconfig").pyright.setup({ capabilities = capabilities })
			require("lspconfig").jdtls.setup({ capabilities = capabilities })
			require("lspconfig").templ.setup({ capabilities = capabilities })
			attachListener()
		end
	}
}
