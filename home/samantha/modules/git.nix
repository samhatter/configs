{...}: {
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Samantha Vincent";
        email = "sammyvincent2001@gmail.com";
      };

      alias = {
        co = "checkout";
        br = "branch";
        ci = "commit";
        st = "status";
        lg = "log --oneline --graph --decorate --all --color";
      };

      init.defaultBranch = "main";

      core = {
        editor = "nvim";
        pager = "less -FRX"
      };
      
      pull = {
        rebase = true;
      };
    };
  };
}
