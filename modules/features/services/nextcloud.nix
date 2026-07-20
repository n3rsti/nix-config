{
  flake.nixosModules.nextcloud =
    {
      pkgs,
      config,
      ...
    }:
    {
      sops.secrets.nextcloud-admin-pass = { };

      services.nextcloud = {
        enable = true;
        https = true;
        package = pkgs.nextcloud33;
        hostName = "nextcloud.tail3ce7af.ts.net";
        database.createLocally = true;
        config.adminpassFile = "/run/secrets/nextcloud-admin-pass";
        config.dbtype = "pgsql";
        settings.trusted_domains = [
          "localhost"
          "server.tail3ce7af.ts.net"
          "nextcloud.tail3ce7af.ts.net"
          "100.72.98.44"
        ];
        extraApps = {
          inherit (config.services.nextcloud.package.packages.apps) contacts calendar tasks;
        };
        extraAppsEnable = true;
        configureRedis = true;
      };

      services.tailscaleServe.apps.nextcloud.target = "http://127.0.0.1:80";

      services.postgresqlBackup = {
        databases = [ "nextcloud" ];
      };

      sops.secrets.borgbackup_passphrase_nextcloud = { };

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
    };
}
