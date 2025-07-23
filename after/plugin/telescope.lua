local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Telescope live grep for git files' })
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({search = vim.fn.input("Grep > ")});
end)

require("telescope").setup {
    defaults = {
      mappings = {
        i = {
          ["<CR>"] = require("telescope.actions").select_tab,
        },
        n = {
          ["<CR>"] = require("telescope.actions").select_tab,
        },
      },
    },
  }
