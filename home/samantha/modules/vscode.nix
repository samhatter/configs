{
  pkgs,
  nixpkgs-fork,
  ...
}: let
  forkPkgs = import nixpkgs-fork {
    system = pkgs.stdenv.hostPlatform.system;
    config = pkgs.config;
  };
in {
  programs.vscode = {
    enable = true;
    package = forkPkgs.vscode;
  };
}
