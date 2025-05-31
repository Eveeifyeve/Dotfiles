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
use the following command to rebuild the configuration:
```bash
nix-rebuild  
```
if this shell alias is not working, use the following command:
```bash
darwin-rebuild switch --flake ~/.dotfiles --verbose |& nom
```

# Flake templates

## Available templates

* Node: node
* Rust: rust
* Fenix (Rust): rust.fenix
* Rust Overlay: rust.rust-overlay
* Poetry: python.poetry
* Python: python
* uv: python.uv
* Zig: zig

### Install template using cli
Get started by using the cli to install a template from github.
Replace `<template-name>` with the [name of the template](#available-templates) you want to install.
```bash
nix flake init -t github:eveeifyeve/dotfiles#<template-name>
```

### Adding it to your config using flake
```nix
{
    inputs = {
        eveeifyeve-flake-templates = {
            url = "github:eveeifyeve/dotfiles";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, eveeifyeve-flake-templates, ... }:
    {
        templates = inputs.eveeifyeve-flake-templates.templates;
    }
}
```

# Updating 

A Simple update can be done by running: `nix flake update`
