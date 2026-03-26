Create `sftpgo-secrets.sops.yaml` from `sftpgo-secrets.sops.yaml.example`, encrypt it with SOPS, and add it to `kustomization.yaml` before reconciling.

Expected secret keys:

- `default-admin-username`
- `default-admin-password`

The admin UI will be served at `https://sftpgo.samantha-home-server.net/web/admin`.
The SFTP listener is exposed on TCP port `2022`.
