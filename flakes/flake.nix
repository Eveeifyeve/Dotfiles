{
  description = "Template Flakes for Nix/NixOS";

  outputs = { self, nixpkgs }: {
    templates = {
      node = {
        path = ./node;
        description = "NodeJS development environment";
      };

      rust = {
        path = ./rust;
        description = "Rust development environment";
      };
    };
  };
}