return {
  {
    'chrisaddy/graphite.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
    },
    config = function()
      require('graphite').setup()
      require('which-key').add {
        { '<leader>g', group = '[G]it' },
        { '<leader>gb', '<cmd>GraphiteBranches<cr>', desc = '[G]it [B]ranches' },
      }
    end,
  },
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
      'kdheepak/lazygit.nvim',
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('octo').setup()
      require('which-key').add {
        { '<leader>g', group = '[G]it' },
        { '<leader>gp', group = '[G]it Pull Requests' },
        { '<leader>gi', group = '[G]it Issues' },
        { '<leader>gil', '<cmd>Octo issue list<cr>', desc = '[G]it Issue List' },
        { '<leader>gic', '<cmd>Octo issue create<cr>', desc = '[G]it Issue Create' },
        { '<leader>gpc', '<cmd>Octo pr create<cr>', desc = '[G]it Pull [R]equest [C]reate' },
        { '<leader>gg', '<cmd>LazyGit<cr>', desc = '[G]it dashboard' },
        { '<leader>gpl', '<cmd>Octo pr list<cr>', desc = '[G]it [P]ull Request [L]ist' },
      }
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Jump to next git [c]hange' })

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Jump to previous git [c]hange' })

        -- Actions
        -- visual mode
        map('v', '<leader>hs', function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'stage git hunk' })
        map('v', '<leader>hr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'reset git hunk' })
        -- normal mode
        map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
        map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
        map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
        map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = 'git [u]ndo stage hunk' })
        map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
        map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
        map('n', '<leader>hb', gitsigns.blame_line, { desc = 'git [b]lame line' })
        map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
        map('n', '<leader>hD', function()
          gitsigns.diffthis '@'
        end, { desc = 'git [D]iff against last commit' })
        -- Toggles
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
        map('n', '<leader>tD', gitsigns.toggle_deleted, { desc = '[T]oggle git show [D]eleted' })

        vim.api.nvim_set_hl(0, 'GitSignsAdd', { fg = '#00ff00', bg = 'NONE' }) -- Green for additions, no background
        vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = '#ffff00', bg = 'NONE' }) -- Yellow for changes, no background
        vim.api.nvim_set_hl(0, 'GitSignsDelete', { fg = '#ff0000', bg = 'NONE' }) -- Red for deletions, no background
        vim.api.nvim_set_hl(0, 'GitSignsChangeDelete', { fg = '#ff00ff', bg = 'NONE' }) -- Magenta for changed deletions, no background
        vim.api.nvim_set_hl(0, 'GitSignsTopDelete', { fg = '#ffff00', bg = 'NONE' }) -- Yellow for top deletions, no background
      end,
    },
  },
}
