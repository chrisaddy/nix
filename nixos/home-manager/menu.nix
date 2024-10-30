{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs.tofi = {
    enable = true;
    settings = {
      width = "100%";
      height = "100%";
      border-width = 0;
      outline-width = 0;
      padding-left = "35%";
      padding-top = "35%";
      result-spacing = 25;
      num-results = 10;
      font = "monospace";
      prompt-text = "/ ";
      background-color = "#000A";
      text-color = "#81C8BE";
      selection-color = "#F4B8E4";
    };
  };

  programs.wlogout = {
    enable = true;
  };
}
