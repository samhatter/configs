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
      set cursorline      " highlight current line
      set termguicolors   " 24-bit colors
      set background=dark
      colorscheme gruvbox
      syntax on
      filetype plugin indent on

      " File explorer
      nnoremap <leader>e :Explore<CR>

    '';

    extraLuaConfig = ''
      -- Nil (Nix)
      vim.lsp.config("nil_ls", {
        cmd = { "nil" },
        filetypes = { "nix" },
        root_markers = { "flake.nix", ".git" },
        settings = {
          ['nil'] = {
            formatting = {
              command = { "alejandra" },
            },
          },
        },
      })

      vim.lsp.enable("nil_ls")


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

      -- LSP keymaps
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          local opts = { buffer = event.buf }

          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>f", function()
            vim.lsp.buf.format({ async = true })
          end, opts)
        end,
      })
    '';
  };
}
