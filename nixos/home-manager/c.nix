{
  config,
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    gcc14
    llvmPackages_17.clang-unwrapped
    cmake
    libtool
  ];
}
