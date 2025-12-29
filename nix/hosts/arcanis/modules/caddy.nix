{...}: {
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
}
