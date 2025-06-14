{
  pkgs,
  inputs,
  lib,
  ...
}:
let
  apc-extension = pkgs.fetchFromGitHub {
    owner = "drcika";
    repo = "apc-extension";
    rev = "d4cc908bf2869fe354aa0c103bab063aa09fd491";
    hash = "sha256-RfzaP+a7ukLCqL2+Ty6xFGnmgkc8lcpd1G2Xy4sr8IE=";
  };
in
with pkgs;
[
  # Development Tools
  jetbrains.idea-community # For java colab

  # (vscode.overrideAttrs (attrs: {
  #   postInstall = ''
  #     cd $out
  #     mkdir apc-extension

  #     sed '1d' ${apc-extension}/src/patch.ts >> $out/apc-extension/patch.ts
  #     sed "s%require.main!.filename%'$out/lib/vscode/resources/app/out/dummy'%g" -i  $out/apc-extension/patch.ts
  #     sed "s%vscode.window.showErrorMessage(%throw new Error(installationPath + %g" -i  $out/apc-extension/patch.ts
  #     sed "s%promptRestart();%%g" -i  $out/apc-extension/patch.ts

  #     sed '1d' ${apc-extension}/src/utils.ts > $out/apc-extension/utils.ts
  #     ls $out/apc-extension >> log

  #     echo "import { install } from './patch.ts'; install({ extensionPath: '${apc-extension}' })" > $out/apc-extension/install.ts

  #     bun apc-extension/install.ts
  #   '';
  #   buildInputs = attrs.buildInputs ++ [
  #     pkgs.bun
  #   ];
  # }))

  skeditor
  btop
  bytecode-viewer
  ripgrep
  tree
  codeberg-cli # File Sizes

  # Command Line Proccesors
  bat # Better cat
  ripgrep
  gawk
  fzf # Fuzzy Finder

  # Programs
  # spotify
  element-desktop
  audacity
  tailscale

  # Nix Tools
  nixd
  nix-output-monitor

  # Private Browsing / DarkWeb Browsers

  # Minecraft
  prismlauncher
  modrinth-app

  # Video/Photo/Graphic Editingc
  gimp
  ffmpeg_7-full

  # Music Downloaders
  spotdl

  # Productivity
  obsidian

  # Git Utils/Ui's
  lazygit
  #TODO: Wait until git-revice is fixed for macos.
  # git-revise

  # Secrets
  inputs.agenix.packages."${system}".default

  # Fonts
  nerd-fonts.jetbrains-mono
]
