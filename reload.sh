#!/usr/bin/env bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Detect user and hostname
USER="${USER:-$(whoami)}"
HOSTNAME="${HOSTNAME:-$(hostname)}"

echo -e "${BLUE}==> Detected: ${USER}@${HOSTNAME}${NC}"

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Paths to flakes
HOME_FLAKE="${SCRIPT_DIR}/home"
NIX_FLAKE="${SCRIPT_DIR}/nix"

# Check if configurations exist
HOME_CONFIG="${USER}@${HOSTNAME}"
NIXOS_CONFIG="${HOSTNAME}"

echo -e "${BLUE}==> Checking for configurations...${NC}"

# Check if home-manager config exists by trying to build it
if nix build "${HOME_FLAKE}#homeConfigurations.\"${HOME_CONFIG}\".activationPackage" --dry-run 2>/dev/null; then
    HM_EXISTS=true
    echo -e "${GREEN}✓ Found home-manager config: ${HOME_CONFIG}${NC}"
else
    HM_EXISTS=false
    echo -e "${YELLOW}✗ No home-manager config found for: ${HOME_CONFIG}${NC}"
fi

# Check if NixOS config exists by trying to build it
if nix build "${NIX_FLAKE}#nixosConfigurations.${NIXOS_CONFIG}.config.system.build.toplevel" --dry-run 2>/dev/null; then
    NIXOS_EXISTS=true
    echo -e "${GREEN}✓ Found NixOS config: ${NIXOS_CONFIG}${NC}"
else
    NIXOS_EXISTS=false
    echo -e "${YELLOW}✗ No NixOS config found for: ${NIXOS_CONFIG}${NC}"
fi

if [ "$HM_EXISTS" = false ] && [ "$NIXOS_EXISTS" = false ]; then
    echo -e "${RED}Error: No configurations found for ${USER}@${HOSTNAME}${NC}"
    exit 1
fi

# Reload home-manager if config exists
if [ "$HM_EXISTS" = true ]; then
    echo -e "\n${BLUE}==> Building home-manager configuration...${NC}"
    if home-manager switch -b backup --flake "${HOME_FLAKE}#${HOME_CONFIG}"; then
        echo -e "${GREEN}✓ Home-manager configuration applied successfully${NC}"
    else
        echo -e "${RED}✗ Home-manager configuration failed${NC}"
        exit 1
    fi
fi

# Reload NixOS if config exists and we have sudo
if [ "$NIXOS_EXISTS" = true ]; then
    if [ -f /etc/NIXOS ]; then
        echo -e "\n${BLUE}==> Building NixOS configuration...${NC}"
        if sudo nixos-rebuild switch --flake "${NIX_FLAKE}#${NIXOS_CONFIG}"; then
            echo -e "${GREEN}✓ NixOS configuration applied successfully${NC}"
        else
            echo -e "${RED}✗ NixOS configuration failed${NC}"
            exit 1
        fi
    else
        echo -e "${YELLOW}⚠ Not running on NixOS, skipping system configuration${NC}"
    fi
fi

echo -e "\n${GREEN}==> All done!${NC}"
