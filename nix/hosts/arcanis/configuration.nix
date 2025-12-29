{ config, pkgs, ... }:

{
  imports =
    [ ./hardware-configuration.nix ../profiles/base.nix ./modules/caddy.nix ];

  networking.hostName = "arcanis";
  networking.networkmanager.enable = true;

  users.users.samantha = {
    isNormalUser = true;
    description = "samantha";
    extraGroups = [ "networkmanager" "wheel" "docker" "video" "render" ];
    openssh.authorizedKeys.keyFiles = [ /home/samantha/.ssh/authorized_keys ];
  };

  users.mutableUsers = false;
  security.sudo.enable = true;

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

  system.stateVersion = "23.11";

}
