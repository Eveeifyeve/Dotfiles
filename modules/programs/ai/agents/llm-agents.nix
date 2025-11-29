{ inputs, ... }:
{
  flake-file.inputs.llm-agents.url = "github:numtide/llm-agents.nix";
  nixpkgs.overlays = [
    inputs.llm-agents.overlays.default
  ];
}
