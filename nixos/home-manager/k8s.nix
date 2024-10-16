{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    k9s
    kubectl
    eksctl
    eks-node-viewer
  ];
}
