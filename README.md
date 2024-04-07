# Dotfiles 
A Configuration for Each Distro/OS

# Features
- Rust & Node Flake Templates to get you started
- Editor Configurations for VsCode and Nvim








# Installing 


## Macos 


1. Download this folder and move it to .dotfiles

2. Download Nix | https://nixos.org/download/

3. Build the configuration using:
```bash
nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/.dotfiles/
```




# Rebuilding 

## Macos
```bash
darwin-rebuild switch --flake ~/.dotfiles/   
```





Took insperation off: https://github.com/Aylur/dotfiles