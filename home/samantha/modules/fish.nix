{pkgs, ...}: {
  programs.fish = {
    enable = true;

    plugins = [
      {
        name = "grc";
        src = pkgs.fishPlugins.grc;
      }
    ];

    shellInit = ''
      status --is-interactive; and set -gx EDITOR nvim
      status --is-interactive; and set -gx PAGER less
    '';

    interactiveShellInit = ''
      set -g fish_greeting
      set -gx LESS -FRi
      set -gx NIXPKGS_ALLOW_UNFREE 1


      function fish_prompt
          if set -q VIRTUAL_ENV
              set_color green
              echo -n "("(basename "$VIRTUAL_ENV")") "
          end

          set_color green
          echo -n (whoami)"@"(hostname -s)" "
          set_color blue
          echo -n (prompt_pwd)

          if git rev-parse --is-inside-work-tree >/dev/null 2>&1
              set -l branch (git rev-parse --abbrev-ref HEAD 2>/dev/null)
              if test "$branch" = "HEAD" -o -z "$branch"
                  set branch (git rev-parse --short HEAD 2>/dev/null)
              end

              set -l dirty ""
              git diff --quiet --ignore-submodules -- 2>/dev/null; or set dirty "*"

              if test -n "$branch"
                  set_color yellow
                  echo -n " ($branch$dirty)"
              end
          end

          echo -n "> "
      end
    '';
  };
}
