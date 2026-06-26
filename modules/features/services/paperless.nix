{
  flake.nixosModules.paperless =
    {
      pkgs,
      ...
    }:
    {
      services.paperless = {
        enable = true;
        settings = {
          PAPERLESS_URL = "https://paperless.tail3ce7af.ts.net";
          configureTika = true;
        };
      };

      sops.secrets.borgbackup_passphrase_paperless = { };

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

      environment.systemPackages = with pkgs; [
        ocrmypdf
      ];
    };
}
