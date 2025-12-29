{ config, pkgs, ... }:

{
  sops.secrets."samantha-password" = {
    sopsFile = ../../secrets/shared/passwords.yaml;
    format = "yaml";
    key = "samantha_password";
    mode = "0400";
    neededForUsers = true;
  };

  users.users.samantha = {
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "video"
      "render"
    ];
    shell = pkgs.fish;
    hashedPasswordFile = config.sops.secrets."samantha-password".path;
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC8znB6gc3QM1zqTpOW4WQbDuaJGdmqdZzyDyt/DFGqWj7vEYmYQdRG9/aVVRn0GEKCzF9u6WgdmUNYZkxPVdl5ujCuA+EHmBuj+bbgg/lsBXXcNdgrSw/SnDpJd8mEvpaCuePKsKp/rErr3FKNYqzJxI5iRV1qYbHWsbYRF0lrsEtJUSm9/VnA5oYWp0kVu9E5YlbZpRXN5Bp5LLU1HV+ucor6LVY5Osgjy5RcsmmPLdLwhIhmm8y/0sMV6cepkFDVA2WjiHypHwdjIELlnrjb3JPPoAZYu1Cowi62JWGpVKgppYNvNiBOOS9qR6Z+BR/hlVA/uZWARPvHPmLtHSxgdQ/iHkvKg9Me6SR9cHFBCfSoxotHyWmfbDL7fjfUpz6SdueZG/NB4xWEZd+C8ZqhLokbrCmQvfEeMi38t6K2kzgFHl31x+Woj8kpgs2na4TtvqsGV3xdyuOOANiDlF4AeTmSNMNWhtKff/3dTmLiVSBJBQGdfINl+WO7bQ49tMgge+gZfHhH/1n7HOGJVoW51Ux88WAPIqAjw3qyihVHVZbP9zuSRHf9zpcW5ssn68kDu5phlHvdycuEyfUgtUpwWzU97hmD8pLRHAWcXON1dem3ovRPCHahziKdWS+LtLeQxwJEdB3h6CUqTcDle7YkyqVpkvK8W7pjDfIVnVwpUw== iPhone Termius"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAqyo2VMjVksxMS0uNtepN2oHLjme1lloB3EpWmch40/ sammy@mishra"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHYPYk8fH6GlvOR4J9fxS6jb5pqPCtEw0NacU0SuBT4X samanthavincent@Samanthas-MacBook-Pro.local"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGSgHsql24Wx3SosGqvSGtVq0VsdyZ2f8SYIBbg2zIAI samantha@snapcaster"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDREtiARFeF6oQEkVQeyfX0t8X3soPNv6puVXJfOXq1C samantha@tarmogoyf"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJhY28/mGm59ibWCwyTnof92vWosXzZVEGPnbEf0/ppL samantha@scapeshift"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKcZcDOSjq6ZkiQ4vaBY2KKNaZhnPRzlPqJPhJPD1qxD samantha@arcanis"
    ];
    createHome = true;
  };

  sops.age.keyFile = "/var/lib/sops-nix/keys.txt";
}
