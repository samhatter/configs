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
            "samantha-home-server.net" = {
                user = "samantha";
            };
            "10.0.0.69" = {
                user = "samantha";
            };
        };
    };
}