{ pkgs, nixpkgs-fork, ... }:
{
  imports = [
    ../modules/kitty.nix
    ../modules/vscode.nix
  ];
  
  nixpkgs.overlays = [
    (
      final: prev:
      let
        forkPkgs = import nixpkgs-fork {
          system = final.stdenv.hostPlatform.system;
          config = prev.config;
        };
      in
      {
        plex-desktop = forkPkgs.plex-desktop;
      }
    )
  ];


  home.packages = with pkgs; [
    chromium
    plex-desktop
    plexamp
    gnome-tweaks
    gnomeExtensions.dash-to-dock
    gnomeExtensions.resource-monitor
    discord
  ];
}
