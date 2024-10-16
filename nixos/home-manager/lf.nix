{
  config,
  pkgs,
  username,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    glow
    zathura
  ];

  home.file = {
    "${config.xdg.configHome}/glow/config".text = ''
      style: "auto"
      local: false
      mouse: false
      pager: true
      width: 80
    '';
  };

  programs.lf = {
    enable = true;
    settings = {
      preview = true;
      hidden = true;
      icons = true;
      ignorecase = true;
    };
    cmdKeybindings = {};
    commands = {
      editor-open = ''
        $$EDITOR $f
      '';
      open = ''
        ''${{
          case $(file --mime-type "$f" -b) in
            application/pdf) zathura "$f" ;;
            *) xdg-open "$f" ;;
          esac
        }}
      '';
      mkdir = ''
        ''${{
            printf "directory name: "
            read DIR
            mkdir $DIR
          }}
      '';
    };
    keybindings = {
      c = "mkdir";
      "." = "set hidden!";
      "<enter>" = "editor-open";
      gh = "cd";
      "g/" = "/";
      gp = ''
        cd ${config.home.homeDirectory}/projects
      '';
      v = ''
        ${pkgs.bat}/bin/bat --paging=always "$f"
      '';
    };
    extraConfig = let
      previewer = pkgs.writeShellScriptBin "pv.sh" ''
        ${pkgs.pistol}/bin/pistol $1
      '';
    in ''
      set previewer ${previewer}/bin/pv.sh
    '';
  };
}
