{ inputs, ... }:
{
  flake-file.inputs.llm-agents = {
    url = "github:numtide/llm-agents.nix";
    inputs = {
      nixpkgs.follows = "nixpkgs";
      systems.follows = "systems";
      treefmt-nix.follows = "treefmt";
      flake-parts.follows = "flake-parts";
    };
  };

  nixpkgs.overlays = [
    inputs.llm-agents.overlays.shared-nixpkgs
  ];
}
