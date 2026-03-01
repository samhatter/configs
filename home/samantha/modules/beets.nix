{ pkgs, ... }: {
  programs.beets = {
    enable = true;
    package = pkgs.beets.override {
      python3 = pkgs.python313.withPackages (ps: [
        ps.beetcamp
      ]);
    };
  };
}
