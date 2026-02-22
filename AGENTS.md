# AGENTS.md

Context for AI agents working in this repository.

---

## Overview

This is **samantha's infrastructure-as-code monorepo**. It declaratively manages NixOS systems, user environments, a Kubernetes homelab, and encrypted secrets — all from a single repo.

There are four top-level concerns:

| Directory | Purpose |
|-----------|---------|
| `nix/` | NixOS system-level configurations (one flake) |
| `home/` | Home Manager user-level configurations (separate flake) |
| `clusters/` | Kubernetes manifests deployed via Flux GitOps |
| `secrets/` | SOPS-encrypted secrets (age-key-based) |

---

## Hosts

Every host is named after a **Magic: The Gathering card**.

| Host | Role | Hardware | Notes |
|------|------|----------|-------|
| `snapcaster` | Workstation | ThinkPad T490s | Imports `workstation` profile |
| `tarmogoyf` | Workstation | ThinkPad P14s | Imports `workstation` profile |
| `twin` | Workstation | Dell Media PC | Imports `workstation` profile |
| `scapeshift` | WSL instance | Gaming PC (WSL) | Uses `nixos-wsl` module; no `hardware-configuration.nix` |
| `arcanis` | Server | — | Runs k3s; also uses `nixos-wsl` module in flake; has extra modules (`k3s.nix`, `firewall.nix`) |

Each host has:
- A NixOS config at `nix/hosts/<host>/configuration.nix` (+ `hardware-configuration.nix` where applicable)
- A Home Manager entry at `home/samantha/hosts/<host>.nix`
- An age public key anchored in `/.sops.yaml`

---

## Directory Layout

```
nix/
├── flake.nix                        # nixosConfigurations for all 5 hosts
├── hosts/
│   ├── snapcaster/                  # configuration.nix, hardware-configuration.nix
│   ├── tarmogoyf/                   #   "
│   ├── twin/                        #   "
│   ├── scapeshift/                  # configuration.nix only (WSL)
│   └── arcanis/
│       ├── configuration.nix
│       ├── hardware-configuration.nix
│       └── modules/
│           ├── k3s.nix              # k3s server setup (disables built-in traefik)
│           └── firewall.nix
├── profiles/
│   ├── base.nix                     # Common to all hosts (bootloader, locale, nix gc, etc.)
│   ├── workstation.nix              # Desktop-specific (GNOME, audio, printing, etc.)
│   └── wsl.nix                      # WSL-specific tweaks
└── users/
    └── samantha.nix                 # User account definition

home/
├── flake.nix                        # homeConfigurations for samantha@<host>
└── samantha/
    ├── hosts/
    │   ├── snapcaster.nix           # Imports base + workstation profiles
    │   ├── tarmogoyf.nix
    │   ├── twin.nix
    │   ├── scapeshift.nix
    │   └── arcanis.nix              # Imports base profile only; adds fluxcd
    ├── profiles/
    │   ├── base.nix                 # fish, gh, git, neovim, ssh
    │   └── workstation.nix          # kitty, vscode, GUI apps (uses nixpkgs-fork for plex-desktop)
    └── modules/                     # Self-contained, single-tool modules
        ├── element.nix
        ├── fish.nix
        ├── gh.nix
        ├── git.nix
        ├── kitty.nix
        ├── neovim.nix
        ├── ssh.nix
        └── vscode.nix

clusters/arcanis/                    # Flux-managed k3s cluster
├── flux-system/                     # Flux bootstrap (gotk-components, gotk-sync)
├── traefik/                         # Ingress controller (deployed manually, not via k3s built-in)
├── adguard/
├── ddns/
├── homepage/
├── matrix/
├── matrix-call/
├── monitoring/                      # Prometheus, Grafana, cAdvisor, node-exporter, kube-state-metrics
├── nickatcher/
├── openclaw/
├── plex/
├── prowlarr/
├── qbittorrent/
├── radarr/
├── randomart/
├── slskd-name-reservation-bot/
├── sonarr/
├── soulseek/
├── unifi/
└── web-graffiti/

secrets/
└── shared/
    └── passwords.yaml               # Encrypted with all 5 host age keys
```

Kubernetes apps with `*.sops.yaml` files (e.g. `matrix/matrix-postgres.sops.yaml`) are encrypted using only the `arcanis` key, as defined in `/.sops.yaml`.

---

## Flake Architecture

Both flakes (`nix/flake.nix` and `home/flake.nix`) share the same structure:

- **nixpkgs**: `github:NixOS/nixpkgs/nixos-25.11`
- **nixpkgs-fork**: `github:samhatter/nixpkgs?ref=sammy-dev` — custom package overrides (e.g. `plex-desktop`), passed via `specialArgs` / `extraSpecialArgs`
- **sops-nix**: `github:Mic92/sops-nix` — secret decryption at build time
- **Formatter**: `alejandra` (set as `formatter.x86_64-linux` in both flakes)

The NixOS flake additionally uses:
- **nixos-wsl**: `github:nix-community/NixOS-WSL` — imported by `scapeshift` and `arcanis`

The Home Manager flake additionally uses:
- **home-manager**: `github:nix-community/home-manager/release-25.11`

---

## Key Patterns

- **Profiles are composable.** Host configs import from `profiles/` to share common settings. A workstation host imports both `base.nix` and `workstation.nix`; a server imports only `base.nix`.
- **Modules are atomic.** Each file in `home/samantha/modules/` configures exactly one tool and can be imported independently.
- **Two separate flakes.** NixOS and Home Manager are independent flakes with independent lockfiles. They are rebuilt together via `reload.sh` but can be applied individually.
- **k3s Traefik is disabled.** The built-in k3s Traefik is turned off (`--disable=traefik` in `k3s.nix`); a custom Traefik deployment lives in `clusters/arcanis/traefik/`.
- **SOPS rules.** `/.sops.yaml` defines two creation rules: `secrets/shared/*` is encrypted to all 5 hosts; `clusters/arcanis/*.sops.*` is encrypted to `arcanis` only.

---

## Commands

```bash
# Rebuild everything (auto-detects host and available configs)
./reload.sh

# NixOS only
sudo nixos-rebuild switch --flake ./nix#<hostname>

# Home Manager only
home-manager switch -b backup --flake ./home#samantha@<hostname>

# Format all Nix files (alejandra)
nix fmt .

# Encrypt / re-key secrets after adding a host
sops updatekeys secrets/shared/passwords.yaml
```

---

## Adding a New Host

1. Generate an age key on the new machine: `age-keygen >> /var/lib/sops-nix/keys.txt`
2. Add the public key as a new anchor in `/.sops.yaml` and run `sops updatekeys` on every encrypted file that should include it.
3. Create `nix/hosts/<mtg-card-name>/` with `configuration.nix` (and `hardware-configuration.nix` if not WSL).
4. Add a `nixosConfigurations.<name>` entry in `nix/flake.nix` — include `sops-nix.nixosModules.sops` and (if WSL) `nixos-wsl.nixosModules.default`.
5. Create `home/samantha/hosts/<name>.nix` importing the appropriate profiles.
6. Add a `homeConfigurations."samantha@<name>"` entry in `home/flake.nix` — include `sops-nix.homeManagerModules.sops` and pass `hostName` via `extraSpecialArgs`.

---

## Rules for Agents

- **Always format before committing.** Run `nix fmt .` — the formatter is `alejandra`.
- **Respect the fork.** When a package comes from `nixpkgs-fork` (the `samhatter/nixpkgs` fork on `sammy-dev`), use `forkPkgs.<pkg>` — see `home/samantha/profiles/workstation.nix` for the pattern.
- **Don't hardcode secrets.** Anything sensitive goes through SOPS. Kubernetes secrets use `*.sops.yaml` with `encrypted_regex: ^(data|stringData)$`.
- **All x86_64-linux.** Every host is `system = "x86_64-linux"`.
- **stateVersion is `24.11`.** Don't change `home.stateVersion` or `system.stateVersion` unless intentional.
- **Kustomizations.** Each Kubernetes app directory has a `kustomization.yaml` listing its resources. When adding a new manifest, remember to add it there too.
- **Cluster app convention.** Each app under `clusters/arcanis/` typically has: `namespace.yaml`, `deployment.yaml`, `service.yaml`, `kustomization.yaml`, and optionally `ingress.yaml` and `*.sops.yaml`.
