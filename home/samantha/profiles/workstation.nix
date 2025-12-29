{ pkgs, ... }: {
  imports = [ ../modules/vscode.nix ];
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
