{ pkgs, ... }:
{
    programs.neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
        withPython3 = true;

        plugins = with pkgs.vimPlugins; [
            nvim-lspconfig
        ];

        extraPackages = with pkgs; [
            nil
            alejandra
        ];

        extraConfig = ''
            set number          " show line numbers
            set relativenumber  " relative line numbers
            set tabstop=4       " spaces per tab
            set shiftwidth=4    " spaces per indent
            set expandtab       " convert tabs to spaces
            set smartindent     " auto-indent new lines
            set clipboard=unnamedplus " use system clipboard
            set cursorline      " highlight current line
            set termguicolors   " 24-bit colors
            syntax on
            filetype plugin indent on
        '';

        extraLuaConfig = ''
            local lsp = require("lspconfig")

            lsp.nil_ls.setup({
                settings = {
                ["nil"] = {
                    formatting = { command = { "alejandra" } },
                },
                },
            })

            vim.keymap.set("n", "<leader>f", function()
                vim.lsp.buf.format({ async = true })
            end, { desc = "Format file with LSP" })
        '';
    };
}