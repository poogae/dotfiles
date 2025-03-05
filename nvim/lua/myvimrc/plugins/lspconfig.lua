local on_attach = function(_, bufnr)
	local set_keymap = function(mode, keys, func, opts)
		opts = opts or {}
		opts.buffer = bufnr
		vim.keymap.set(mode, keys, func, opts)
	end

	set_keymap("n", "[lsp]", "<Nop>")
	set_keymap("n", "<Space><Space>", "[lsp]", { remap = true })

	set_keymap("n", "[lsp]d", vim.lsp.buf.definition, { desc = "Go to definition" })
	set_keymap("n", "[lsp]D", vim.lsp.buf.declaration, { desc = "Go to declaration" })
	set_keymap("n", "[lsp]I", vim.lsp.buf.implementation, { desc = "Go to implementation" })
	set_keymap("n", "[lsp]y", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
	set_keymap("n", "[lsp]r", vim.lsp.buf.references, { desc = "List references" })

	set_keymap("n", "[lsp]ds", vim.lsp.buf.document_symbol, { desc = "List document symbols" })
	set_keymap("n", "[lsp]ws", vim.lsp.buf.workspace_symbol, { desc = "List workspace symbols" })

	-- keymap('n', 'K', vim.lsp.buf.hover, { desc = 'Show documentation' })
	-- keymap('n', 'gK', vim.lsp.buf.signature_help, { desc = 'Show signature' })
	-- keymap('i', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Show signature' })

	-- keymap('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename symbol' })
	-- keymap('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code action' })

	-- keymap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { desc = 'Add workspace folder' })
	-- keymap('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { desc = 'Remove workspace folder' })
	-- keymap(
	-- 'n',
	-- '<leader>wl',
	-- function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
	-- { desc = 'List workspace folders' }
	-- )
end

return {
	"neovim/nvim-lspconfig",
	ft = {
		"lua",
		"go",
		"python",
		"java",
		"yaml",
		"rust",
	},
	dependencies = {
		"williamboman/mason.nvim", -- loads lsp servers
		"hrsh7th/cmp-nvim-lsp",
	},
	opts = {
		servers = {
			lua_ls = {
				settings = {
					Lua = {
						workspace = { checkThirdParty = false },
						telemetry = { enable = false },
					},
				},
			},
			pyright = {
				settings = {
					pyright = {
						-- Using Ruff's import organizer
						disableOrganizeImports = true,
					},
					python = {
						analysis = {
							-- Ignore all files for analysis to exclusively use Ruff for linting
							ignore = { "*" },
						},
					},
				},
			},
			ruff = {},
			jdtls = {},
			rust_analyzer = {
				settings = {
					["rust-analyzer"] = {
						check = {
							command = "clippy",
						},
					},
				},
			},
		},
	},
	config = function(_, opts)
		local lspconfig = require("lspconfig")
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		for name, conf in pairs(opts.servers) do
			lspconfig[name].setup({
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					local _, err = pcall(on_attach, client, bufnr)
					if err then
						vim.notify("[on_attach] error: " .. err, vim.log.levels.ERROR)
					else
						vim.notify(
							"[on_attach] " .. client.name .. " attached to buffer " .. bufnr,
							vim.log.levels.INFO
						)
					end
				end,
				settings = conf.settings,
			})
		end
	end,
}
