{ pkgs, ... }:
{
  dconf.settings = {
    "org/gnome/settings-daemon/plugins/power" = {
      power-button-action = "interactive";
      sleep-inactive-ac-type = "nothing";
    };

    "org/gnome/desktop/datetime" = {
      automatic-timezone = true;
    };

    "org/gnome/desktop/interface" = {
      font-hinting = "full";
      font-antialiasing = "rgba";
    };
  };

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "IBM Plex Mono" ];
      serif = [ "IBM Plex Serif" ];
      sansSerif = [ "IBM Plex Sans" ];
    };
  };

  gtk = {
    enable = true;
    font = {
      name = "IBM Plex Sans";
      package = pkgs.ibm-plex;
    };
  };
}
