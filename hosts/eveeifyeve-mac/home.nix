{
  config,
  pkgs,
  git,
  lib,
  inputs,
  ...
}:
{
  imports = [
    ../../modules/homemanager
    ../../modules/homemanager/git.nix
    ../../modules/homemanager/terminal.nix
  ];
  programs.alacritty = {
    enable = true;
    settings = {
      window.option_as_alt = "OnlyLeft";
      window.decorations = "None";
    };
  };

  programs.aerospace = {
    enable = true;
    userSettings = {
      start-at-login = true;

      enable-normalization-flatten-containers = true;
      automatically-unhide-macos-hidden-apps = true;
      enable-normalization-opposite-orientation-for-nested-containers = true;
      accordion-padding = 30;
      default-root-container-layout = "tiles";
      default-root-container-orientation = "auto";

      gaps =
        let
          generalgap = 15;
        in
        {
          inner = {
            horizontal = generalgap;
            vertical = generalgap;
          };
          outer = {
            left = generalgap + 55;
            bottom = generalgap;
            top = generalgap;
            right = generalgap;
          };
        };

      mode.main.binding =
        {
          alt-t = "exec-and-forget alacritty";
          alt-shift-h = "move left";
          alt-shift-j = "move down";
          alt-shift-k = "move up";
          alt-shift-l = "move right";
          alt-h = "focus left";
          alt-j = "focus down";
          alt-k = "focus up";
          alt-l = "focus right";
        }
        // builtins.listToAttrs (
          builtins.concatLists (
            builtins.genList (
              i:
              let
                ws = toString i;
              in
              [
                {
                  name = "alt-${ws}";
                  value = "workspace ${ws}";
                }
                {
                  name = "alt-shift-${ws}";
                  value = "move-node-to-workspace ${ws}";
                }
              ]
            ) 10
          )
        );
    };
  };
  home = {
    username = "eveeifyeve";
    stateVersion = "25.05";
    homeDirectory = "/Users/${config.home.username}";
    packages =
      pkgs.callPackage ../packages.nix { inherit inputs; }
      ++ (with pkgs; [
        mas
        aldente
        bartender
        stats
        raycast # MacOS Spotlight Alternative
        utm # MacOS Qemu
        arc-browser # Only here until zen browser is stable
        # darwin.xcode_15_1
      ]);
    shellAliases.nix-rebuild = "darwin-rebuild switch --flake ~/.dotfiles --verbose |& nom";
  };
  nix.settings.allowed-users = [
    "eveeifyeve"
    "root"
  ];
}
