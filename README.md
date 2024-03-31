# Dotfiles 
A Configuration for Each Distro/OS

# Features
- MacOS Nix and NixOs config
- Neovim config







# Installing 


## Macos 


1. Download this folder and move it to .dotfiles

2. Download Nix | https://nixos.org/download/

3. Build the configuration using:
```bash
nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/.dotfiles/.config/nix-darwin
```




# Rebuilding 

## Macos
```bash
nix run nix-darwin -- switch --flake ~/.dotfiles/.config/nix-darwin
```