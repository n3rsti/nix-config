_: {
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    age.keyFile = "/var/lib/sops-nix/key.txt";
    age.generateKey = true;
  };

  sops.secrets = {
    hetzner_storagebox = { };
    borgbackup_passphrase_immich = { };
    borgbackup_passphrase_nextcloud = { };
    borgbackup_passphrase_paperless = { };
  };

  environment.sessionVariables = {
    SOPS_AGE_KEY_FILE = "/var/lib/sops-nix/key.txt";
  };
}
