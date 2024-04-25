# Dotfiles 
A Configuration for Each Distro/OS

# Features
- Nix Flake Templates with Devenv.
- Editor Configurations for VsCode and Nvim.
- HomeBrew installed for MacOS Applications that are not on Nix.
- Modularity like setup with ability to disable a program easily.
- Support for Different Hosts Easily
And [More](./doc/features.md).







# Installing 

> [!NOTE]
> NixOS is coming very soon 

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


# Documentation

- [Flake Templates](/flakes/README.md)