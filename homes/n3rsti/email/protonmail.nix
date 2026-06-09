_:
{
  services.protonmail-bridge.enable = true;

  accounts.email.accounts = {
    protonmail = {
      primary = true;
      address = "n3rsti@protonmail.com";
      userName = "n3rsti@protonmail.com";
      realName = "Krzysztof Witucki";
      aliases = [
        "n3rsti@pm.me"
        "kwitucki@protonmail.com"
      ];
      imap = {
        host = "127.0.0.1";
        port = 1143;
        authentication = "plain";
        tls.useStartTls = true;
      };

      smtp = {
        host = "127.0.0.1";
        port = 1025;
        authentication = "plain";
        tls.useStartTls = true;
      };

      thunderbird = {
        enable = true;
        profiles = [ "default" ];
      };
    };
  };
}
