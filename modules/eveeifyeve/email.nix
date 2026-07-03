{
  users.eveeifyeve =
    { config, ... }:
    {
      home.base.sops.secrets = {
        personal-google-password = {
          sopsFile = ../secrets/personal-google-password;
          format = "binary";
        };
        personal-email-address = {
          sopsFile = ../secrets/personal-email-address;
          format = "binary";
        };
        junk-google-password = {
          sopsFile = ../secrets/junk-google-password;
          format = "binary";
        };
      };

      accounts.emails = {
        Personal = {
          address = config.sops.secrets.personal-email-address;
          passwordSopsName = "personal-google-password";
          flavor = "outlook.office365.com";
          primary = true;
        };

        Junk = {
          passwordSopsName = "junk-google-password";
          address = "eveeg1971@gmail.com";
        };
      };
    };
}
