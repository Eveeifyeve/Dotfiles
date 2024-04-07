{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default";
    devenv.url = "github:cachix/devenv";
  };

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs = { self, nixpkgs, devenv, systems, ... } @ inputs:
    let
      forEachSystem = nixpkgs.lib.genAttrs (import systems);
    in
    {
      devShells = forEachSystem
        (system:
          let
            pkgs = nixpkgs.legacyPackages.${system};
            nodejs-packages = with pkgs.nodePackages; [
              vscode-langservers-extracted
              typescript-language-server
              yarn
            ];
          in
          {
            default = devenv.lib.mkShell {
              inherit inputs pkgs;
              modules = [
                {
                  difftastic.enable = true;

                  # Enviroment Virables
                  env = {
                  };

                  # https://devenv.sh/reference/options/
                  packages = with pkgs;
                    [] ++ nodejs-packages;

                  # https://devenv.sh/scripts/
                  # scripts.hello.exec = "";

                  # enterShell = ''
                  # '';

                  # https://devenv.sh/languages/
                  languages.javascript = {
                    enable = true;
                  };

                  languages.typescript = {
                    enable = true;
                  };

                  # https://devenv.sh/pre-commit-hooks/
                  pre-commit.hooks = {
                    hooks.nixfmt.package = pkgs.nixfmt-rfc-style;
                    nixfmt.enable = true;
                    yamllint.enable = true;
                    editorconfig-checker.enable = true;
                    rome.enable = true;
                  };

                  # Plugin configuration
                  pre-commit.settings = {
                    yamllint.relaxed = true;
                  };

                  # https://devenv.sh/integrations/dotenv/
                  dotenv.enable = true;

                }
              ];
            };
          });
    };
}