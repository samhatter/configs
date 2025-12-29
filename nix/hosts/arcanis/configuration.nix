{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ../profiles/base.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "arcanis";
  networking.networkmanager.enable = true;

  #   time.timeZone = "America/Los_Angeles";

  #   i18n.defaultLocale = "en_US.UTF-8";

  #   i18n.extraLocaleSettings = {
  #     LC_ADDRESS = "en_US.UTF-8";
  #     LC_IDENTIFICATION = "en_US.UTF-8";
  #     LC_MEASUREMENT = "en_US.UTF-8";
  #     LC_MONETARY = "en_US.UTF-8";
  #     LC_NAME = "en_US.UTF-8";
  #     LC_NUMERIC = "en_US.UTF-8";
  #     LC_PAPER = "en_US.UTF-8";
  #     LC_TELEPHONE = "en_US.UTF-8";
  #     LC_TIME = "en_US.UTF-8";
  #   };

  users.users.samantha = {
    isNormalUser = true;
    description = "samantha";
    extraGroups = [ "networkmanager" "wheel" "docker" "video" "render" ];
    packages = with pkgs; [ vim git kitty ];
    openssh.authorizedKeys.keyFiles = [ /home/samantha/.ssh/authorized_keys ];
  };

  services.getty.autologinUser = "samantha";

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [ git ];

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

  services.caddy = {
    enable = true;
    email = "sammyvincent2001@gmail.com";
    virtualHosts."plex.samantha-home-server.net".extraConfig = ''
      reverse_proxy 127.0.0.1:32400
    '';
    virtualHosts."langfuse.samantha-home-server.net".extraConfig = ''
      reverse_proxy 127.0.0.1:3136
    '';
    virtualHosts."torrent.samantha-home-server.net".extraConfig = ''
      reverse_proxy 127.0.0.1:1024
    '';
    virtualHosts."soulseek.samantha-home-server.net".extraConfig = ''
      reverse_proxy 127.0.0.1:2048
    '';
    virtualHosts."portainer.samantha-home-server.net".extraConfig = ''
      reverse_proxy 127.0.0.1:9000
    '';
    virtualHosts."grafana.samantha-home-server.net".extraConfig = ''
      reverse_proxy 127.0.0.1:3000
    '';
    virtualHosts."prowlarr.samantha-home-server.net".extraConfig = ''
      reverse_proxy 127.0.0.1:9696
    '';
    virtualHosts."sonarr.samantha-home-server.net".extraConfig = ''
      reverse_proxy 127.0.0.1:8989
    '';
    virtualHosts."radarr.samantha-home-server.net".extraConfig = ''
      reverse_proxy 127.0.0.1:7878
    '';
    virtualHosts."samantha-home-server.net".extraConfig = ''
      reverse_proxy 127.0.0.1:2727
    '';
    virtualHosts."files.samantha-home-server.net".extraConfig = ''
      root * /storage/media
      basicauth {
        samantha $2y$10$JDXdH3Lxsm2pkiEnO1233.dozuzZq5fvos2PCrrjjntrH1Q4tqc/a
      }
      file_server browse
    '';
    virtualHosts."web-graffiti.samantha-home-server.net".extraConfig = ''
      reverse_proxy 127.0.0.1:5554
    '';
    virtualHosts."unifi.samantha-home-server.net".extraConfig = ''
      reverse_proxy 127.0.0.1:8443 {
        transport http {
              tls_insecure_skip_verify
          }
       }
    '';
  };

  networking.firewall.enable = false;

  fileSystems."/storage" = {
    device = "/dev/pool/storage";
    fsType = "ext4";
  };

  system.stateVersion = "23.11";

}
