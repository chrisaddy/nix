{
  config,
  inputs,
  pkgs,
  ...
}: {

  home.packages = with pkgs; [
    pfetch-rs
    direnv
  ];

  programs = {
    nushell = {
      enable = true;
      shellAliases = {
        vi = "nvim";
        vim = "nvim";
        nano = "nvim";
      };
      extraConfig = ''
        let carapace_completer = {|spans|
          carapace $spans.0 nushell $spans | from json
        }
        $env.config = {
          completions: {
            case_sensitive: false
            quick: true
            partial: true
            algorithm: "fuzzy"
          }
          hooks: {
            pre_prompt: [{ ||
              if (which direnv | is-empty) {
                return
              }
              direnv export json | from json | default {} | load-env
            }]
          }
        }
      '';
    };
    carapace.enable = true;
    carapace.enableNushellIntegration = true;
    starship = {
      enable = true;
    };
  };
}
