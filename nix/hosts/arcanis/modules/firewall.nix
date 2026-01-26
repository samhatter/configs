{
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      # Exposed through NAT
      200 # Obfuscated SSH
      80 # HTTP
      443 # HTTPS
      32400 # Plex
      5349 # TURN TLS
      7881 # RTC TCP

      # ONLY on host
      6443 # Kubernetes API
      8080 #
    ];
    allowedUDPPorts = [
      #Exposed through NAT
      3487 # TURN UDP
      7882 # RTC UDP

      #ONLY on host
      32410 # Plex GDM
      32412 # Plex GDM
      32413 # Plex GDM
      32414 # Plex GDM
    ];

    allowedUDPPortRanges = [
      #Exposed through NAT
      {
        from = 50100;
        to = 50200;
      } # RTC UDP RANGE
    ];
  };
}
