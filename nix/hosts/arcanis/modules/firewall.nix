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
      53 # AdGuard DNS
      3000 # AdGuard Setup UI
      853 # DNS-over-TLS
      5443 # DNSCrypt
      8080 # UniFi Device Adoption
      8443 # UniFi Web UI
    ];
    allowedUDPPorts = [
      53 # AdGuard DNS
      67 # AdGuard DHCP
      68 # AdGuard DHCP
      784 # DNSCrypt
      853 # DNS-over-TLS
      5443 # DNSCrypt
      8853 # DNS-over-QUIC
      10001 # UniFi L2 Discovery
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
