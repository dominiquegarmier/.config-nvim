require('nvim-treesitter.configs').setup({
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python", "rust", "javascript", "cpp", "go", "ocaml",
    "html", "css", "json", "yaml", "toml", "bash", "dockerfile" },
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  indent = { enable = true },
})
