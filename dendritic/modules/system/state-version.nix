{
  inputs,
  ...
}:
{
  flake.modules.nixos.state-version = {
    system.stateVersion = inputs.self.lib.stateVersion;
  };

  flake.modules.darwin.state-version = {
    system.stateVersion = inputs.self.lib.darwinStateVersion;
  };

  flake.modules.homeManager.state-version = {
    home.stateVersion = inputs.self.lib.stateVersion;
  };

  flake.lib.stateVersion = "26.05";
  flake.lib.darwinStateVersion = 6;
}
