{pkgs, ...}: {
  networking.hostName = "snapcaster";
  networking.firewall.enable = false;

  imports = [
    ../../profiles/base.nix
    ../../profiles/workstation.nix
    ../../users/samantha.nix
    ./hardware-configuration.nix
  ];

  services.fprintd = {
    enable = true;
    package = pkgs.fprintd-tod;
    tod.enable = true;
    tod.driver = pkgs.libfprint-2-tod1-goodix-550a;
  };

  security.pam.services = {
    sudo.fprintAuth = false;
  };

  services.power-profiles-daemon.enable = true;

  services.hardware.bolt.enable = true;

  system.stateVersion = "24.05";
}
