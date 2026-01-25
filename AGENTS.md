# AGENTS.md

This file provides context for AI agents working with this repository.

## What Is This Repo?

This is **samantha's personal infrastructure-as-code monorepo** containing:

1. **NixOS system configurations** (`/nix`) - Full operating system declarations
2. **Home Manager configurations** (`/home`) - User environment and dotfiles
3. **Kubernetes/Flux cluster configs** (`/clusters`) - GitOps for k3s homelab
4. **Secrets** (`/secrets`) - SOPS-encrypted secrets (age keys)

## Naming Convention

All hosts are named after **Magic: The Gathering cards**:
- `snapcaster` - Workstation (Thinkpad T490s)
- `tarmogoyf` - Workstation  (Thinkpad P14s)
- `twin` - Workstation (Dell Media PC)
- `scapeshift` - WSL instance (Gaming PC WSL)
- `arcanis` - Server running k3s

## Directory Structure

```
/nix                    # NixOS flake (system-level configs)
  /flake.nix           # Defines nixosConfigurations for each host
  /hosts/<hostname>/   # Per-host configs (configuration.nix, hardware-configuration.nix)
  /profiles/           # Reusable NixOS profiles (base.nix, workstation.nix, wsl.nix)
  /users/              # User account definitions

/home                   # Home Manager flake (user-level configs)
  /flake.nix           # Defines homeConfigurations for samantha@<host>
  /samantha/hosts/     # Per-host home configs
  /samantha/modules/   # Individual tools (fish, git, neovim, vscode, etc.)
  /samantha/profiles/  # Reusable home profiles (base.nix, workstation.nix)

/clusters               # Kubernetes GitOps (Flux)
  /arcanis/            # k3s cluster running on the arcanis host
    /flux-system/      # Flux bootstrap components
    /<app>/            # App deployments (namespace, deployment, service, ingress)

/secrets                # SOPS-encrypted secrets
  /shared/passwords.yaml
```

## Key Technologies

- **NixOS 25.11** - Declarative Linux distribution
- **Home Manager 25.11** - Declarative user environment management
- **Nix Flakes** - Reproducible Nix builds with lockfiles
- **SOPS + age** - Secret encryption (keys stored at `/var/lib/sops-nix/keys.txt`)
- **k3s** - Lightweight Kubernetes on `arcanis`
- **Flux** - GitOps continuous delivery for Kubernetes
- **Traefik** - Ingress controller

## Common Commands

```bash
# Full rebuild (both NixOS and Home Manager)
./reload.sh

# NixOS only
sudo nixos-rebuild switch --flake ./nix#<hostname>

# Home Manager only
home-manager switch -b backup --flake ./home#samantha@<hostname>

# Format Nix files
nix fmt .

# Update SOPS keys after adding new host
sops updatekeys secrets/shared/passwords.yaml
```

## Adding a New Host

1. Generate age key on new machine: `age-keygen >> /var/lib/sops-nix/keys.txt`
2. Add public key to `.sops.yaml` and run `sops updatekeys`
3. Create `/nix/hosts/<mtg-name>/` with `configuration.nix` and `hardware-configuration.nix`
4. Add nixosConfiguration entry to `/nix/flake.nix`
5. Create `/home/samantha/hosts/<mtg-name>.nix`
6. Add homeConfiguration entry to `/home/flake.nix`

## Important Notes for Agents

- **Formatter**: Use `alejandra` (configured in both flakes). Run `nix fmt .` before committing.
- **Fork reference**: Both flakes reference `nixpkgs-fork` from `samhatter/nixpkgs` for custom packages.
- **WSL host**: `scapeshift` uses `nixos-wsl` module.
- **Profiles are composable**: Hosts import from `/profiles/` for shared config.
- **Modules are atomic**: Each tool in `/home/samantha/modules/` is self-contained.
- **k3s config**: The `arcanis` host has k3s setup in `/nix/hosts/arcanis/modules/k3s.nix`.
