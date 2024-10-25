{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    kubectl
    eksctl
    eks-node-viewer
  ];

  programs = {
    k9s = {
      enable = true;
      #   plugin = {
      #     blame = {
      #       shortcut = "b";
      #       confirm = false;
      #       description = "Blame";
      #       scopes = [
      #         "all"
      #       ];
      #       command = "sh";
      #       background = false;
      #       args = [
      #         "-c"
      #         "${pkgs.kubectl-blame}/bin/kubectl-blame"
      #         "$RESOURCE_NAME"
      #         "$NAME"
      #         "-n"
      #         "$NAMESPACE"
      #         "--context"
      #         "$CONTEXT"
      #         "|"
      #         "less"
      #       ];
      #     };
      #   };
    };
  };
}
