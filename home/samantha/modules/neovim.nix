{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    withPython3 = true;

    plugins = with pkgs.vimPlugins; [
      gruvbox
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
    ];

    extraPackages = with pkgs; [
      nil
      alejandra
    ];

    extraConfig = ''
      let mapleader=' '
      set number          " show line numbers
      set tabstop=2       " spaces per tab
      set shiftwidth=2    " spaces per indent
      set expandtab       " convert tabs to spaces
      set smartindent     " auto-indent new lines
      set clipboard+=unnamedplus " use system clipboard
      set cursorline      " highlight current line
      set termguicolors   " 24-bit colors
      set background=dark
      colorscheme gruvbox
      syntax on
      filetype plugin indent on
    '';

    extraLuaConfig = ''
      -- Alejandra (Nix)
      vim.lsp.config("alejandra", {
        cmd = { "alejandra" },
        filetypes = { "nix" },
        root_markers = { "flake.nix", ".git" },
      })

      vim.lsp.enable("alejandra")


      -- Pyright (Python)
      vim.lsp.config("pyright", {
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_markers = {
          "pyproject.toml",
          "setup.py",
          "setup.cfg",
          "requirements.txt",
          ".git",
        },

        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
            },
          },
        },
      })

      vim.lsp.enable("pyright")

      -- Gopls (Go)
      vim.lsp.config.gopls = {
        cmd = { "gopls" },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        root_markers = { "go.work", "go.mod", ".git" },
        settings = {
          gopls = {
            gofumpt = true,
            analyses = {
              unusedparams = true,
              nilness = true,
              unusedwrite = true,
            },
            staticcheck = true,
          },
        },
      }

      vim.lsp.enable("gopls")



      -- Treesitter
      require'nvim-treesitter.configs'.setup {
        highlight = {
           enable = true,
        },
        indent = {
          enable = true,
        },
      }

      -- Keymaps
      vim.keymap.set("n", "<leader>f", function()
          vim.lsp.buf.format({ async = true })
      end, { desc = "Format file with LSP" })
    '';
  };
}
