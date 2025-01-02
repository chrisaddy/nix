{
  config,
  pkgs,
  ...
}: {
  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    globals = {
      mapleader = " ";
      maplocalleader = " ";
      have_nerd_font = true;
    };
    opts = {
      number = true;
      relativenumber = true;
      swapfile = false;
      backup = false;
      undofile = true;
      hlsearch = true;
      incsearch = true;
      termguicolors = true;
    };
    colorschemes.tokyonight = {
      enable = true;
      settings = {
        style = "storm";
        transparent = true;
      };
    };
    plugins = {
      lazygit = {
        enable = true;
      };
      lint = {
        enable = true;
      };
      lualine = {
        enable = true;
      };
      neotest = {
        enable = true;
        settings = {
          log_level = "error";
          output = {
            enable = true;
            open_on_run = true;
          };
          quickfix = {
            enable = true;
          };
          discovery = {
            enable = true;
          };
          consumers = {
          };
        };
      };

      # return {
      #   'nvim-neotest/neotest',
      #   dependencies = {
      #     'nvim-neotest/nvim-nio',
      #     'nvim-lua/plenary.nvim',
      #     'antoinemadec/FixCursorHold.nvim',
      #     'nvim-neotest/neotest-python',
      #     'nvim-neotest/neotest-plenary',
      #   },
      #   config = function()
      #     require('neotest').setup {
      #       consumers = {
      #         require 'neotest-plenary',
      #       },
      #       adapters = {
      #         require 'neotest-python',
      #         require 'neotest-plenary',
      #       },
      #     }
      #   end,
      # }

      neo-tree = {
        enable = true;
        enableDiagnostics = true;
        enableGitStatus = true;
        enableModifiedMarkers = true;
        enableRefreshOnWrite = true;
        autoCleanAfterSessionRestore = true;
        gitStatusAsync = true;
      };
      nvim-autopairs = {
        enable = true;
      };
      octo = {
        enable = true;
      };
      oil = {
        enable = true;
        settings = {
          default_file_explorer = true;
          columns = [
            "icon"
            "permissions"
            "size"
            "mtime"
          ];
          buf_options = {
            buflisted = true;
            bufhidden = "hide";
          };
          view_options = {
            show_hidden = true;
          };
          float = {
            padding = 2;
            max_width = 0;
            max_height = 0;
            border = "rounded";
            win_options = {
              winblend = 0;
            };
          };
          preview_split = "auto";
        };
      };
      rustaceanvim = {
        enable = true;
      };
      telescope = {
        enable = true;
      };
      treesitter = {
        enable = true;
      };
      undotree = {
        enable = true;
        settings = {
          autoOpenDiff = true;
          focusOnToggle = true;
        };
      };
      web-devicons = {
        enable = true;
      };
      which-key = {
        enable = true;
        settings = {
          add = "hellii";
        };
      };
      # return {
      #   {
      #     'folke/which-key.nvim',
      #     event = 'VimEnter', -- Sets the loading event to 'VimEnter'
      #     config = function() -- This is the function that runs, AFTER loading
      #       require('which-key').setup()
      #       require('which-key').add {
      #         { '<leader>c', group = '[C]ode' },
      #         { '<leader>d', group = '[D]ocument' },
      #         { '<leader>g', group = '[G]it' },
      #         { '<leader>r', group = '[R]ename' },
      #         { '<leader>s', group = '[S]earch' },
      #         { '<leader>w', group = '[W]orkspace' },
      #         { '<leader>t', group = '[T]oggle' },
      #       }
      #     end,
      #   },
      # }
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>ut";
        action = "<cmd>UndoTreeToggle<cr>";
        options = {
          silent = true;
          desc = "[u]ndo [t]ree";
        };
      }
      {
        mode = "n";
        key = "<leader>o";
        action = "<cmd>Oil<cr>";
        options = {
          silent = true;
          desc = "[o]il";
        };
      }
      {
        mode = "n";
        key = "<leader>ff";
        action = "find_files";
        options = {
          desc = "[f]ind [f]iles";
        };
      }
      {
        mode = "n";
        key = "<leader>gg";
        action = "<cmd>LazyGit<cr>";
        options = {
          silent = true;
          desc = "[g]it dashboard";
        };
      }
      {
        mode = "n";
        key = "<leader>gil";
        action = "<cmd>Octo issue list<cr>";
        options = {
          silent = true;
          desc = "[g]it [i]ssue [l]ist";
        };
      }
      {
        mode = "n";
        key = "<leader>gic";
        action = "<cmd>Octo issue create<cr>";
        options = {
          silent = true;
          desc = "[g]it [i]ssue [c]reate";
        };
      }
      {
        mode = "n";
        key = "<leader>gpl";
        action = "<cmd>Octo pr list<cr>";
        options = {
          silent = true;
          desc = "[g]it [p]r list";
        };
      }
      {
        mode = "n";
        key = "<leader>gpc";
        action = "<cmd>Octo pr create<cr>";
        options = {
          silent = true;
          desc = "[g]it [p]r [c]reate";
        };
      }
      {
        mode = "n";
        key = "<leader>rt";
        action = "<cmd>Neotest run<cr>";
        options = {
          silent = true;
          desc = "[r]un [t]ests";
        };
      }
      {
        mode = "n";
        key = "<leader>tt";
        action = "<cmd>Neotree toggle<cr>";
        options = {
          silent = true;
          desc = "[t]oggle [t]ree";
        };
      }
    ];
  };
}
