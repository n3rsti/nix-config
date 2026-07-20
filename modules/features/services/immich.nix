{
  flake.nixosModules.immich = _: {

    services.immich.enable = true;

    services.tailscaleServe.apps.immich.target = "http://localhost:2283";

    sops.secrets.borgbackup_passphrase_immich = { };

    services.borgbackup.jobs.immich-backup = {
      paths = "/var/lib/immich";
      encryption = {
        mode = "repokey-blake2";
        passCommand = "cat /run/secrets/borgbackup_passphrase_immich";
      };
      environment.BORG_RSH = "ssh -p 23 -i /run/secrets/hetzner_storagebox";
      repo = "u557087@u557087.your-storagebox.de:./backups/immich";
      compression = "auto,zstd";
      startAt = "daily";
      prune.keep = {
        within = "7d";
        daily = 7;
        weekly = 4;
        monthly = 3;
        yearly = 1;
      };
    };
  };
}
