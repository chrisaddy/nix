{
  config,
  lib,
  pkgs,
  ...
}: {
  services.aerospace = {
    enable = true;
    settings = {
      gaps = {
        window = {
          inner = 8;
          outer = 8;
        };
      };
      window-margins = true;
      window-margin-size = 8;
    };
  };
}
