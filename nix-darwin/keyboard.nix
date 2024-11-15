{
  config,
  pkgs,
  ...
}: {
  home.file.".config/karabiner/karabiner.json".text = builtins.toJSON {
    global = {
      check_for_updates_on_startup = true;
      show_in_menu_bar = true;
      show_profile_name_in_menu_bar = false;
    };
    profiles = [
      {
        name = "Default";
        selected = true;
        simple_modifications = [
          {
            from = {key_code = "caps_lock";};
            to = [{key_code = "left_control";}];
          }
          {
            from = {key_code = "escape";};
            to = [
              {
                key_code = "left_control";
                modifiers = ["left_control"];
              }
            ];
          }
        ];
        complex_modifications = {
          parameters = {
            "basic.simultaneous_threshold_milliseconds" = 50;
            "basic.to_delayed_action_delay_milliseconds" = 500;
            "basic.to_if_alone_timeout_milliseconds" = 1000;
            "basic.to_if_held_down_threshold_milliseconds" = 500;
          };
          rules = [];
        };
      }
    ];
  };
}
