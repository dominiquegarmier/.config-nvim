local builtin = require('telescope.builtin')
local telescope = require('telescope')

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[f]ind [f]iles' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[f]ind [g]rep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[f]ind [b]uffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[f]ind [h]elp' })


telescope.setup({
  -- .. other settings
  extensions = {
    file_browser = {
      hijack_netrw = true,
    },
  },
})

-- file browser
telescope.load_extension "file_browser"
vim.keymap.set("n", "<space>ft", ":Telescope file_browser<CR>", { noremap = true, desc = '[f]ile [t]ree' })

-- git worktree
telescope.load_extension "git_worktree"
vim.keymap.set('n', '<leader>gw', function() telescope.extensions.git_worktree.git_worktrees() end,
  { noremap = true, desc = '[g]it [w]orktrees' })
vim.keymap.set('n', '<leader>gc', function() telescope.extensions.git_worktree.create_git_worktree() end,
  { noremap = true, desc = '[g]it [c]reate [w]orktree' })

-- other git stuff
vim.keymap.set('n', '<leader>gs', function() builtin.git_status() end, { noremap = true, desc = '[g]it [s]tatus' })
vim.keymap.set('n', '<leader>gc', function() builtin.git_commits() end, { noremap = true, desc = '[g]it [c]ommits' })
vim.keymap.set('n', '<leader>gb', function() builtin.git_branches() end, { noremap = true, desc = '[g]it [b]ranches' })
