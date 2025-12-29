{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../profiles/base.nix
    ../../users/samantha.nix
    ./modules/caddy.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "arcanis";
  networking.networkmanager.enable = true;

  users.users.samantha = {
    isNormalUser = true;
    description = "samantha";
    extraGroups = [ "networkmanager" "wheel" "docker" "video" "render" ];
    openssh.authorizedKeys.keyFiles = [ /home/samantha/.ssh/authorized_keys ];
  };

  services.getty.autologinUser = "samantha";

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [ libva libva-utils mesa ];
  };

  virtualisation = {
    docker = {
      enable = true;
      liveRestore = false;
      daemon.settings = {
        experimental = true;
        metrics-addr = "0.0.0.0:9323";
      };
    };

    oci-containers = {
      backend = "docker";
      containers = {
        portainer = {
          image = "portainer/portainer";
          ports = [ "9000:9000" ];
          volumes = [
            "/etc/portainer:/data"
            "/var/run/docker.sock:/var/run/docker.sock"
          ];
        };
      };
    };
  };

  services.openssh = {
    enable = true;
    ports = [ 200 ];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  networking.firewall.enable = false;

  fileSystems."/storage" = {
    device = "/dev/pool/storage";
    fsType = "ext4";
  };

  programs.nix-ld.enable = true;

  system.stateVersion = "23.11";
  
}
