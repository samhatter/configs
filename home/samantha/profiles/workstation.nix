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
  imports = [
    ../modules/kitty.nix
    ../modules/vscode.nix
  ];

  home.packages = with pkgs; [
    chromium
    forkPkgs.plex-desktop
    plexamp
    gnome-tweaks
    gnomeExtensions.dash-to-dock
    gnomeExtensions.resource-monitor
    discord
    element-desktop
    pyenv
  ];
}
