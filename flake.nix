# DO-NOT-EDIT. This file was auto-generated using github:vic/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{
  outputs = inputs: import ./outputs.nix inputs;

  nixConfig = {
    extra-experimental-features = [ "pipe-operators" ];
  };

  inputs = {
    caveman = {
      url = "github:JuliusBrussee/caveman";
      flake = false;
    };
    comin = {
      url = "github:nlewo/comin";
      inputs = {
        flake-compat.follows = "flake-compat";
        nixpkgs.follows = "nixpkgs";
      };
    };
    direnv-instant = {
      url = "github:Mic92/direnv-instant";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
      };
    };
    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    files = {
      url = "github:mightyiam/files";
      flake = false;
    };
    finix.url = "github:finix-community/finix";
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-compat.url = "github:NixOS/flake-compat";
    flake-file.url = "github:denful/flake-file";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs = {
        flake-compat.follows = "flake-compat";
        nixpkgs.follows = "nixpkgs";
      };
    };
    home-manager = {
      url = "github:eveeifyeve/home-manager/targets-darwin-persist";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        pre-commit-hooks.follows = "git-hooks";
        systems.follows = "systems";
      };
    };
    hyprland-scroll-overview = {
      url = "github:yayuuu/hyprland-scroll-overview";
      inputs = {
        flake-parts.follows = "nixpkgs";
        hyprland.follows = "hyprland";
        nixpkgs.follows = "nixpkgs";
      };
    };
    import-tree.url = "github:denful/import-tree";
    llm-agents = {
      url = "github:numtide/llm-agents.nix";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
        treefmt-nix.follows = "treefmt";
      };
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixbsd = {
      url = "github:nixos-bsd/nixbsd";
      inputs = {
        flake-compat.follows = "flake-compat";
        nixpkgs.follows = "nixpkgs";
      };
    };
    nixcord = {
      url = "github:kaylorben/nixcord";
      inputs = {
        flake-compat.follows = "flake-compat";
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        nixpkgs-nixcord.follows = "nixpkgs";
      };
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-kotlin-lsp.url = "github:bew/nixpkgs/init-kotlin-lsp";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };
    system-manager = {
      url = "github:nixos-bsd/nixbsd";
      inputs = {
        flake-compat.follows = "flake-compat";
        nixpkgs.follows = "nixpkgs";
      };
    };
    systems.url = "github:nix-systems/default/future-26.11";
    treefmt = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
    };
  };
}
