local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})


-- file browser
require("telescope").load_extension "file_browser"
vim.keymap.set("n", "<space>fb", ":Telescope file_browser<CR>", { noremap = true })
