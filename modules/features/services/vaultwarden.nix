{
  flake.nixosModules.vaultwarden = {
    services = {
      vaultwarden = {
        enable = true;
        backupDir = "/var/backup/vaultwarden";

        config = {
          DOMAIN = "https://vaultwarden.tail3ce7af.ts.net";

          ROCKET_ADDRESS = "127.0.0.1";
          ROCKET_PORT = 8222;

          SIGNUPS_ALLOWED = false;
          SIGNUPS_VERIFY = false;
          INVITATIONS_ALLOWED = false;
        };
      };

      borgbackup.jobs.vaultwarden-backup = {
        persistentTimer = true;
        paths = [
          "/var/backup/vaultwarden"
        ];
        encryption = {
          mode = "repokey-blake2";
          passCommand = "cat /run/secrets/borgbackup_passphrase_vaultwarden";
        };
        environment.BORG_RSH = "ssh -p 23 -i /run/secrets/hetzner_storagebox";
        repo = "u557087@u557087.your-storagebox.de:./backups/vaultwarden";
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

      tailscaleServe.apps = {
        vaultwarden.target = "http://127.0.0.1:8222";
      };

    };
    systemd.services.borgbackup-job-vaultwarden-backup = {
      requires = [ "backup-vaultwarden.service" ];
      after = [ "backup-vaultwarden.service" ];
    };
  };
}
