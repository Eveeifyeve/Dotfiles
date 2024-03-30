{
  description = "My Nix Darwin Config";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    # Declarative tap management
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, homebrew-core, homebrew-cask
    , nix-homebrew, home-manager }:
    let
      user = "eveeifyeve";
      macbook = "eveeifyeve-macbook";
      system = "aarch64-darwin";

      # Configuration
      configuration = { pkgs, ... }: {
        environment.systemPackages = [
          pkgs.vscode
          pkgs.vim
          pkgs.nixfmt
          pkgs.discord
          pkgs.spotify
          pkgs.raycast
          pkgs.git
          pkgs.devenv
          pkgs.nil
        ];
        services.nix-daemon.enable = true;
        system.configurationRevision = self.rev or self.dirtyRev or null;
        system.stateVersion = 4;
        nixpkgs.hostPlatform = system;

        programs.zsh = {
          enable = true;
          interactiveShellInit = ''
            alias rebuildNix='darwin-rebuild switch --flake ~/.config/nix-darwin'
          '';
        };
        # System settings
        security.pam.enableSudoTouchIdAuth = true;
        system.defaults = {
          dock = {
            autohide = true;
            mru-spaces = false;
            show-recents = false;
            orientation = "bottom";
            minimize-to-application = true;
            tilesize = 48;
          };
          finder = {
            CreateDesktop = false;
            AppleShowAllExtensions = true;
            FXDefaultSearchScope = "SCcf";
            ShowPathbar = true;
          };
          screencapture.location = "~/Pictures/screencapture";
          screencapture.type = "png";
          screencapture.disable-shadow = true;
          screensaver.askForPasswordDelay = 10;
        };

        # Bypasses
        nix.settings.experimental-features = "nix-command flakes";
        nix.settings.allowed-users = [ "eveeifyeve" "root" ];
        nixpkgs.config.allowUnfree = true;
      };
    in {
      darwinConfigurations.${macbook} = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              inherit user;
              enable = true;
              enableRosetta = false;
              mutableTaps = false;
              taps = {
                "homebrew/homebrew-core" = homebrew-core;
                "homebrew/homebrew-cask" = homebrew-cask;
              };
            };
          } 
        ];
      };
      darwinPackages = self.darwinConfigurations.pkgs;
    };
}
