_:
{
  accounts.email.accounts = {
    zimbra = {
      address = "krzysztof.witucki@student.put.poznan.pl";
      userName = "krzysztof.witucki@student.put.poznan.pl";
      realName = "Krzysztof Witucki";
      imap = {
        host = "poczta.student.put.poznan.pl";
        port = 143;
        authentication = "plain";
        tls.useStartTls = true;
      };

      smtp = {
        host = "poczta.student.put.poznan.pl";
        port = 587;
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
