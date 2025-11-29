{ inputs, lib, ... }:
{
  flake-file.inputs = {
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  homeManager.modules.gui =
    {
      pkgs,
      config,
      ...
    }:
    {
      imports = [ inputs.zen-browser.homeModules.beta ];
      stylix.targets.zen-browser.profileNames = [ "default" ];
      targets.darwin.defaults = lib.mkIf pkgs.stdenv.isDarwin {
        "app.zen-browser.zen" = {
          EnterprisePoliciesEnabled = true;
        }
        // config.programs.zen-browser.policies;
      };

      programs.zen-browser = {
        enable = true;
        setAsDefaultBrowser = true;
        nativeMessagingHosts = lib.mkIf pkgs.stdenv.isLinux [ pkgs.firefoxpwa ];
        package = lib.mkIf pkgs.stdenv.isDarwin (
          pkgs.lib.makeOverridable (
            _:
            inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.beta-unwrapped.overrideAttrs (old: {
              installPhase = builtins.replaceStrings [ "/usr/bin/codesign" ] [ ": " ] old.installPhase;
              dontFixup = true;
            })
          ) { }
        );

        policies = {
          DisableAppUpdate = true;
          DisableTelemetry = true;
        };
      };
    };
}
