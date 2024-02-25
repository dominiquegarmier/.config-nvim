local lsp_zero = require('lsp-zero')
local lspconfig = require('lspconfig')
local path = lspconfig.util.path

lsp_zero.preset('recommended')

lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  local opts = { buffer = bufnr, remap = false }
  lsp_zero.default_keymaps({ buffer = bufnr })

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
end)


require('mason').setup({})

-- lsp config
require('mason-lspconfig').setup({
  ensure_installed = {
    'lua_ls', 'rust_analyzer', 'pyright', 'clangd', 'ltex', 'tsserver'
  },
  handlers = {
    lsp_zero.default_setup,
  },
})

require('lspconfig').lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
    },
  },
})


local function get_python_path(workspace)
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
  end

  -- Find and use virtualenv in workspace directory.
  for _, pattern in ipairs({ '*', '.*' }) do
    local match = vim.fn.glob(path.join(workspace, pattern, '.venv'))
    if match ~= '' then
      return path.join(path.dirname(match), 'bin', 'python')
    end
  end

  -- Fallback to system Python.
  return 'python3'
end

lspconfig.pyright.setup({
  before_init = function(_, config)
    config.settings.python.pythonPath = get_python_path(config.root_dir)
  end
})

-- auto complete
local cmp = require('cmp')
local cmp_select = { behavoir = cmp.SelectBehavior.Select }
local cmp_mappings = lsp_zero.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
})


-- null ls
local null_ls = require('null-ls')

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.black,
  },
  auto_start = true,
})

require("mason-null-ls").setup({
  ensure_installed = { "black" }
})

vim.keymap.set("n", "<leader>fm", function() vim.lsp.buf.format() end)
