# My Configs

## Quick Commands
- full rebuild: `./reload`
- nixos rebuild: `sudo nixos-rebuild switch --flake ./nix#<host>`
- home manager switch: `home-manager switch -b backup --flake ./home#samantha@<host>`
- fmt: `nix fmt .`
- sops updateKeys: `sops updatekeys /path/to/secret`

## New Device Install/Intake Checklist
For the first installation, you cannot use the reload script. Assumes you have some nixos live usb or older system. Prepare for outcome where sops fails and user password is unknown.

- [ ] Create new age key
    - `nix-shell -p age`
    - `sudo sh -c 'age-keygen >> /var/lib/sops-nix/keys.txt' && chmod 400 /var/lib/sops-nix/keys.txt`
- [ ] Using an existing machine with a valid key, update passwords.yaml for new key.
    - Copy over new public key to `.sops.yaml`
    - `sops updatekeys secrets/shared/passwords.yaml`
    - commit and push
- [ ] Create a new target for host in nix flake
    - create host folder at `/nix/hosts/<mtg inspired name>/`
    - run `nixos-generate-config --dir .` and put hardware config into host folder.
    - copy appropriate `configuration.nix` into host folder, mindful of host name and any hardware specifics.
    - create a new target in `/nix/flake.nix`
    - format with `nix fmt .`
    - commit and push
- [ ] Create a new target for host in home flake
    - create host file at `home/hosts/<magic inspired name>.nix`
    - Include relevant profiles and set appropriate home manager version.
    - format with `nix fmt .`
    - commit and push
- [ ] Build New System
    - `sudo nixos-rebuild switch --flake ./nix#<host>`
    - `home-manager switch -b backup --flake ./home#samantha@<host>`

