{ lib, config, ... }:
{
  options.users = lib.mkOption {
    type = lib.types.lazyAttrsOf (
      lib.types.submodule {
        options.accounts = lib.mkOption {
          type = lib.types.submodule {
            options.emails = lib.mkOption {
              type = lib.types.lazyAttrsOf (
                lib.types.submodule (
                  emailArgs@{ name, ... }:
                  {
                    freeformType = lib.types.attrsOf lib.types.anything;
                    options = {
                      flavor = lib.mkOption {
                        type = lib.types.str;
                        default = "gmail.com";
                      };

                      primary = lib.mkOption {
                        type = lib.types.bool;
                        default = false;
                      };

                      passwordSopsName = lib.mkOption {
                        type = lib.types.str;
                      };

                      smtp.host = lib.mkOption {
                        type = lib.types.str;
                        default =
                          if emailArgs.config.flavor == "gmail.com" then
                            "smtp.gmail.com"
                          else if emailArgs.config.flavor == "outlook.office365.com" then
                            "smtp.office365.com"
                          else
                            throw "Unknown flavor";
                      };
                    };

                    # Remove passwordCommand from here entirely!
                    config = {
                      maildir.path = "${name}";
                      msmtp.enable = true;
                      mbsync = {
                        enable = true;
                        flatten = ".";
                        expunge = "both";
                      };
                    };
                  }
                )
              );
            };
          };
        };
      }
    );
  };

  config =
    lib.genAttrs [ "nixos" "darwin" ] (_: {
      modules.base.home-manager.users =
        config.users
        |> lib.mapAttrs (
          _:
          { accounts, ... }:
          {
            imports = [
              (
                { config, ... }:
                {
                  accounts.email.accounts = lib.mapAttrs (
                    _: emailConfig:
                    {
                      passwordCommand = "cat ${config.sops.secrets.${emailConfig.passwordSopsName}.path}";
                    }
                    // lib.removeAttrs emailConfig [
                      "passwordSopsName"
                    ]

                  ) accounts.emails;
                }
              )
            ];
          }
        );
    })
    // {
      homeManager.modules.base = {
        programs.mbsync.enable = true;
      };
    };
}
