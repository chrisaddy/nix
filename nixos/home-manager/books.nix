{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs = {
    sioyek = {
      enable = true;
      bindings = {
        "move_up" = "e";
        "move_down" = "n";
        "move_left" = "m";
        "move_right" = "i";
        # "screen_down" = [ "<C-n>" ];
        # "screen_up" = [ "<C-e>" ];
      };
    };
  };
}
