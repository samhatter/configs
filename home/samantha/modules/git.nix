{ ... }:
{
    programs.git = {
        enable = true;

        userName = "Samantha Vincent";
        userEmail = "sammyvincent2001@gmail.com";

        aliases = {
            co = "checkout";
            br = "branch";
            ci = "commit";
            st = "status";
            lg = "log --oneline --graph --decorate";
        };

        extraConfig = {
            init.defaultBranch = "main";
        };
    };
}