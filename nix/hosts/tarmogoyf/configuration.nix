{
  config,
  pkgs,
  ...
}: {
  networking.hostName = "tarmogoyf";
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

  hardware.graphics = {
    enable = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement.enable = true;

    open = false;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      sync.enable = true;

      intelBusId = "PCI:0:2:0";

      nvidiaBusId = "PCI:3:0:0";
    };
  };

  system.stateVersion = "24.05";
}
