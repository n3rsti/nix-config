{
  ...
}:
{

  services.borgbackup.jobs.minecraft-backup = {
    paths = "/srv/minecraft/fabric";
    encryption.mode = "none";
    environment.BORG_RSH = "ssh -p 23 -i /run/secrets/hetzner_storagebox";
    repo = "u557087@u557087.your-storagebox.de:./backups/fabric";
    compression = "auto,zstd";
    startAt = "daily";
    prune.keep = {
      within = "3d";
      daily = 7;
      weekly = 2;
    };
  };

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

  services.borgbackup.jobs.nextcloud-backup = {
    paths = "/var/lib/nextcloud";
    encryption = {
      mode = "repokey-blake2";
      passCommand = "cat /run/secrets/borgbackup_passphrase_nextcloud";
    };
    environment.BORG_RSH = "ssh -p 23 -i /run/secrets/hetzner_storagebox";
    repo = "u557087@u557087.your-storagebox.de:./backups/nextcloud";
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

  services.borgbackup.jobs.paperless-backup = {
    paths = "/var/lib/paperless";
    encryption = {
      mode = "repokey-blake2";
      passCommand = "cat /run/secrets/borgbackup_passphrase_paperless";
    };
    environment.BORG_RSH = "ssh -p 23 -i /run/secrets/hetzner_storagebox";
    repo = "u557087@u557087.your-storagebox.de:./backups/paperless";
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
}
