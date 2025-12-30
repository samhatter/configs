{pkgs, ...}:
let
{
  programs.vscode = {
  enable = true;
  package = pkgs.vscode;
  extensions = with pkgs.vscode-extensions; [
    bbenoist.nix
    ms-python.python
    ms-azuretools.vscode-docker
    ms-vscode-remote.remote-ssho
    golang.go
    github.copilot
  ];
};
}
