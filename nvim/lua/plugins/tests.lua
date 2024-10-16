return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest-python',
    'nvim-neotest/neotest-plenary',
    'nvim-neotest/neotest-go',
  },
  config = function()
    require('neotest').setup {
      log_level = vim.g.neotest_log_level or vim.log.levels.ERROR,
      consumers = {
        require 'neotest-plenary',
      },
      adapters = {
        require 'neotest-python',
        require 'neotest-plenary',
        require 'neotest-go' {
          recursive_run = true,
        },
      },
    }
  end,
}
