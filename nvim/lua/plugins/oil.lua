return {
  {
    'stevearc/oil.nvim',
    dependencies = { 'echasnovski/mini.nvim', 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('oil').setup {
        default_file_explorer = true,
        columns = {
          'icon',
          'permissions',
          'size',
          'mtime',
        },
        buf_options = {
          buflisted = true,
          bufhidden = 'hide',
        },
        view_options = {
          show_hidden = true,
        },
        float = {
          padding = 2,
          max_width = 0,
          max_height = 0,
          border = 'rounded',
          win_options = {
            winblend = 0,
          },
          preview_split = 'auto',
        },
      }
      vim.keymap.set('n', '<leader>o', ':Oil<CR>')
    end,
  },
}
