{ inputs, ... }:
{
  flake-file.inputs.github-actions.url = "github:synapdeck/github-actions-nix";

  imports = [
    inputs.github-actions.flakeModules.default
  ];

  perSystem =
    { config, pkgs, ... }:

    let
      installNixSteps = [
        {
          name = "Checkout";
          uses = "actions/checkout@v4";
        }
        {
          name = "Install Nix";
          uses = "cachix/install-nix-action@v24";
        }
      ];
    in
    {
      githubActions = {
        enable = true;

        workflows.pr = {
          name = "Pr Checks";

          on.pullRequest = { };

          jobs.build = {
            runsOn = "ubuntu-latest";
            steps = installNixSteps ++ [
              {
                run = "nix flake check";
              }
            ];
          };
        };
      };
    };
}
