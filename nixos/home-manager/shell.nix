{
  config,
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    zinit
    tree
  ];

  systemd.user = {
    timers.zinit-update = {
      Unit.Description = "zinit plugins update";
      Install.WantedBy = ["timers.target"];
      Timer = {
        OnCalendar = "daily";
        Unit = "zinit-update.service";
        Persistent = true;
      };
    };

    services.zinit-update = {
      Unit.Description = "zinit plugins update";
      Service.ExecStart =
        toString
        (pkgs.writeShellScript "zinit-update.zsh" ''
          echo "update zinit plugins"
          /usr/bin/env zsh -i -c "zinit update --all "
        '');
    };
  };

  programs = {
    awscli = {
      enable = true;
      settings = {
        "default" = {
          region = "us-east-1";
          output = "json";
        };
      };
    };
    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [
        batdiff
        batgrep
        batman
        batwatch
      ];
      config = {
        pager = "less -FR";
        theme = "Dracula";
      };
    };
    bottom = {
      enable = true;
      settings = {
        flags = {
          color = "nord";
          avg_cpu = true;
          group_processes = true;
          tree = true;
          temperature_type = "f";
        };
      };
    };
    broot = {
      enable = true;
      enableZshIntegration = true;
      settings.verbs = [
        {
          invocation = "edit";
          shortcut = "e";
          execution = "$EDITOR {file}";
          leave_broot = false;
          from_shell = true;
        }
        {
          invocation = "p";
          execution = ":parent";
          shortcut = "p";
        }
        {
          invocation = "view";
          execution = "bat {file}";
          shortcut = "v";
        }
      ];
    };
    carapace = {
      enable = true;
      enableZshIntegration = true;
    };
    command-not-found.enable = true;
    dircolors = {
      enable = true;
      enableZshIntegration = true;
    };
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
      silent = true;
    };
    fastfetch.enable = true;
    fd = {
      enable = true;
      hidden = true;
      ignores = [
        ".git/"
      ];
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultOptions = [
        "--preview bat"
      ];
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      historySubstringSearch.enable = true;
      defaultKeymap = "vicmd";
      shellAliases = {
        vi = "nvim";
        vim = "nvim";
        c = "clear";
        emacs = "emacs -nw";
        rg = "batgrep";
      };
      history = {
        size = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
        append = true;
        extended = true;
        expireDuplicatesFirst = true;
        ignoreDups = true;
        share = true;
      };
      dirHashes = {
        projects = "$HOME/projects";
        psf = "$HOME/projects/pocketsizefund/";
        tyrell = "$HOME/projects/pocketsizefund/tyrell";
        nixos = "$HOME/.config/nixos";
      };
       completonInit = {
         autoload -Uz compinit && compinit
         zinit cdreplay -q
      
      };
      initExtra = ''

      '';
    };
  };
}
