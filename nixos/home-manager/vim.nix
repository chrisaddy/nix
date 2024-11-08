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
        action = "<cmd>UndoTreeToggle<CR>";
        options = {
          silent = true;
          desc = "undo tree";
        };
      }
      {
        mode = "n";
        key = "<leader>o";
        action = "<cmd>Oil<CR>";
        options = {
          silent = true;
          desc = "oil";
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
        action = "<cmd>Octo issue list<CR>";
        options = {
          silent = true;
          desc = "[g]it Issue List";
        };
      }
      {
        mode = "n";
        key = "<leader>gic";
        action = "<cmd>Octo issue create<CR>";
        options = {
          silent = true;
          desc = "[g]it Issue Create";
        };
      }
      {
        mode = "n";
        key = "<leader>gpl";
        action = "<cmd>Octo pr list<CR>";
        options = {
          silent = true;
          desc = "[g]it PR List";
        };
      }
      {
        mode = "n";
        key = "<leader>gpc";
        action = "<cmd>Octo pr create<CR>";
        options = {
          silent = true;
          desc = "[g]it PR Create";
        };
      }
    ];
  };
}
