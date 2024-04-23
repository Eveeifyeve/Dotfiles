# Flake Templates 


# Features
- Automatic loading with direnv 
- Flake template for all of my needs 
- Easily orgnized into folders.

# Table of Contents

- [Flake Templates](#flake-templates)
- [Features](#features)
- [Table of Contents](#table-of-contents)
- [Templates](#templates)
  - [Works on Nix/NixOS](#works-on-nixnixos)
  - [Not working on certian platforms](#not-working-on-certian-platforms)
- [Getting Started](#getting-started)
- [Loading](#loading)
  - [Automaticly loading | Prefered way](#automaticly-loading--prefered-way)
  - [Manualy](#manualy)


# Templates 

## Works on Nix/NixOS

- Rust,
- Python,
- Node &
- Tauri.

## Not working on certian platforms

- Java & 
- Kotlin.

# Getting Started 
To get started and to use a template run the follow command below:
```sh
nix flake init -t ~/.dotfiles#<Template>
```
with `#<Template>` with `<Template>` being your template of choice:


# Loading

## Automaticly loading | Prefered way
To get started with loading it automaticly run the following command below to allow it to run:
```sh
direnv allow 
```

This will allow it to run the configuration for your specifiyed tempalte.


## Manualy 
To Load your configuration manualy you can run the following command:

```sh
nix develop --impure
```

This is will load you into and envioment with it there to exit just run `exit` to exit the enviroment.