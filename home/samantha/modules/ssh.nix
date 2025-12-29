{ config, hostName, ... }:
{
  programs.ssh = {
    enable = true;

    matchBlocks = {
      "*" = {
        identityFile = "${config.home.homeDirectory}/.ssh/${hostName}_ed25519";
        identitiesOnly = true;
      };
      "github.com" = {
        user = "git";
      };
      "arcanis" = {
        user = "samantha";
        hostname = "samantha-home-server.net";
      };
      "arcanis-local" = {
        user = "samantha";
        hostname = "10.0.0.2";
      };
      "tarmogoyf" = {
        user = "samantha";
        hostname = "10.0.0.6";
      };
      "snapcaster" = {
        user = "samantha";
        hostname = "10.0.0.9";
      };
    };
  };
}
