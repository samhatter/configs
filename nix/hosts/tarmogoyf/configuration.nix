{config, pkgs, ...}: {
  networking.hostName = "tarmogoyf";
  networking.firewall.enable = false;

  imports = [
    ../../profiles/base.nix
    ../../profiles/workstation.nix
    ../../users/samantha.nix
    ./hardware-configuration.nix
  ];

  
  sops.age.keyFile = "/var/lib/sops-nix/keys.txt";

  services.fprintd = {
    enable = true;
    package = pkgs.fprintd-tod;
    tod.enable = true;
    tod.driver = pkgs.libfprint-2-tod1-goodix-550a;
  };

  security.pam.services = {
    sudo.fprintAuth = false;
  };

  services.power-profiles-daemon.enable = false;

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;
    };
  };

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
