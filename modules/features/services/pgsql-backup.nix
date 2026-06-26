{
  flake.nixosModules.pgsql-backup = { config, ... }: {
    services.postgresqlBackup = {
      enable = config.services.postgresqlBackup.databases != [ ];
      backupAll = false;
      location = "/var/backup/postgresql";
      compression = "zstd";
      startAt = "*-*-* 01:15:00";
    };

    services.borgbackup.jobs.pgsql-backup = {
      paths = "/var/backup/postgresql";
      encryption = {
        mode = "repokey-blake2";
        passCommand = "cat /run/secrets/borgbackup_passphrase_postgresql";
      };
      environment.BORG_RSH = "ssh -p 23 -i /run/secrets/hetzner_storagebox";
      repo = "u557087@u557087.your-storagebox.de:./backups/postgresql";
      compression = "auto,zstd";
      startAt = "*-*-* 02:00:00";
      prune.keep = {
        within = "7d";
        daily = 7;
        weekly = 4;
        monthly = 3;
        yearly = 1;
      };
    };

    sops.secrets.borgbackup_passphrase_postgresql = { };
  };
}
