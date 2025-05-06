local lsp_zero = require("lsp-zero")
local lspconfig = require("lspconfig")
local path = lspconfig.util.path

lsp_zero.preset("recommended")

lsp_zero.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	local opts = { buffer = bufnr, remap = false }
	lsp_zero.default_keymaps({ buffer = bufnr })

	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, opts)
end)

require("mason").setup({})

-- lsp config
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"rust_analyzer",
		"pyright",
		"clangd",
		"tinymist",
	},
	handlers = {
		lsp_zero.default_setup,
	},
})

lspconfig.lua_ls.setup({
	settings = {
		Lua = {
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
		},
	},
})

local function get_python_path(workspace)
	-- Use activated virtualenv.
	if vim.env.VIRTUAL_ENV then
		return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
	end

	if not workspace then
		return "python3"
	end

	-- Find and use virtualenv in workspace directory.
	for _, pattern in ipairs({ "*", ".*" }) do
		local match = vim.fn.glob(path.join(workspace, pattern, ".venv"), false, true)
		if #match > 0 then
			return path.join(path.dirname(match[1]), "bin", "python")
		end
	end

	-- Fallback to system Python.
	return "python3"
end

lspconfig.pyright.setup({
	before_init = function(_, config)
		config.settings.python.pythonPath = get_python_path(config.root_dir)
	end,
})

-- auto complete
local cmp = require("cmp")
local cmp_select = { behavoir = cmp.SelectBehavior.Select }
lsp_zero.defaults.cmp_mappings({
	["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
	["<C-y>"] = cmp.mapping.confirm({ select = true }),
})

-- conform
local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		vue = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		html = { "prettier" },
		css = { "prettier" },
		markdown = { "prettier" },
		python = { "black", "isort" },
		typst = { "typstyle" },
		lua = { "stylua" },
	},
	format_on_save = {
		lsp_fallback = true,
		async = false,
		timeout = 1000,
	},
})

-- isort force single line imports
conform.formatters.isort = {
	prepend_args = { "--sl" },
}

vim.keymap.set("n", "<leader>fm", function()
	conform.format({
		-- lsp_fallback = true,
		async = false,
		timeout = 1000,
	})
end, { desc = "format file" })

-- nvim-lint
local lint = require("lint")

lint.linters_by_ft = {
	python = { "flake8" },
	javascript = { "eslint_d" },
	typescript = { "eslint_d" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	group = lint_augroup,
	callback = function()
		lint.try_lint()
	end,
})

vim.keymap.set("n", "<leader>fl", function()
	lint.try_lint()
end, { desc = "lint file" })
