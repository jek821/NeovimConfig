return {
	"neovim/nvim-lspconfig",
	config = function()
		local lspconfig = require("lspconfig")

		local on_attach = function(_, bufnr)
			local opts = { buffer = bufnr }

			-- LSP Hover (docs/type info)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

			-- LSP Navigation
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
			vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

			-- LSP Diagnostics
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
			vim.keymap.set("n", "<leader>le", vim.diagnostic.open_float, opts)

			-- LSP Utilities
			vim.keymap.set("n", "<leader>lrn", vim.lsp.buf.rename, opts)
			vim.keymap.set("n", "<leader>lca", vim.lsp.buf.code_action, opts)
		end

		lspconfig.pyright.setup({
			on_attach = on_attach,
		})
	end,
}
