{ pkgs, config, ... }:
{
    programs.ssh = {
        enable = true;

        matchBlocks = {
            "*" = {
                identityFile = "${config.home.homeDirectory}/.ssh/snapcaster_ed25519";
                identitiesOnly = true;
            };
            "github.com" = {
                user = "git";
            };
            "arcanis" = {
                user = "samantha";
                hostname = "samantha-home-server.net";
                port = 200;
            };
            "arcanis-local" = {
                user = "samantha";
                hostname = "10.0.0.69";
                port = 200;
            };
        };
    };
}