{
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 200 80 443 32400 5349 7882 ];
    allowedUDPPorts = [ 3487 7882 ];

    allowedUDPPortRanges = [ { from = 50100; to = 50200; } ];

  };
}
