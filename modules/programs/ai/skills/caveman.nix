{ inputs, ... }:
{
  flake-file.inputs.caveman = {
    url = "github:juliusbrussee/caveman";
    flake = false;
  };

  homeManager.modules.gui = {
    programs.opencode.skills =
      let
        skills = [
          "cavecrew"
          "caveman-commit"
          "caveman-compress"
          "caveman-help"
          "caveman-review"
          "caveman-stats"
          "caveman"
        ];
      in
      builtins.listToAttrs (
        map (name: {
          inherit name;
          value = "${inputs.caveman}/skills/${name}";
        }) skills
      );
  };
}
