{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs.python312Packages; [
    pyls-isort
    pyls-flake8
    pylsp-rope
    pylsp-mypy
    python-lsp-ruff
  ];
}
