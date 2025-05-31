#!/bin/env python3

import os
from argparse import ArgumentParser

module_template = """{{config, lib, pkgs, ...}}:
let
  inherit (lib) mkEnableOption mkPackageOption mkOption;
  cfg = config.{cata}.{name};
in
{{
  options.{cata}.{name} = {{
    enable = mkEnableOption "";
    package = mkPackageOption pkgs "";
  }};

  config = lib.mkIf cfg.enable {{}};
}}
"""


def create_module_nix_file(cata, name, file_path):
    content = module_template.format(cata=cata, name=name)
    os.makedirs(os.path.dirname(file_path), exist_ok=True)
    with open(file_path, "w") as f:
        f.write(content)


def find_root_dir():
    current_path = os.getcwd()
    while True:
        if "flake.nix" in os.listdir(current_path):
            return current_path
        parent_path = os.path.dirname(current_path)
        if parent_path == current_path:
            return None
        current_path = parent_path


def main():
    parser = ArgumentParser()
    parser.add_argument("name", type=str, help="Name of the module")
    parser.add_argument(
        "--type",
        "-T",
        type=str,
        required=True,
        help="Type of module (home, darwin, nixos)",
    )
    parser.add_argument("--cata", "-C", type=str, required=True, help="Module category")
    parser.add_argument(
        "--dir",
        "-D",
        action="store_true",
        help="Put the module in /{type}/modules/{cata}/default.nix instead of /{type}/modules/{cata}/{name}.nix",
    )

    args = parser.parse_args()

    root_dir = find_root_dir()
    if not root_dir:
        print("Error: Could not find flake.nix in any parent directory.")
        return

    if args.dir:
        file_path = os.path.join(
            root_dir, args.type, "modules", args.cata, args.name, "default.nix"
        )
    else:
        file_path = os.path.join(
            root_dir, args.type, "modules", args.cata, f"{args.name}.nix"
        )

    create_module_nix_file(args.cata, args.name, file_path)
    print(f"Module created at: {file_path}")


if __name__ == "__main__":
    main()
