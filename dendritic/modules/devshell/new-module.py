#!/bin/env python3

import os
import subprocess
import platform
from argparse import ArgumentParser

module_template = """{{config, lib, ...}}:
{{
  flake-file.inputs.{name}.url = "";
  flake-file.inputs.{name}.inputs.nixpkgs.follows = "nixpkgs";
  flake.modules.nixos.{name} = {{
    imports = [];
  }};

  flake.modules.darwin.{name} = {{
    imports = [];
  }};
}}
"""


def open_in_editor(file_path):
    editor = os.environ.get("EDITOR")
    if editor:
        subprocess.call([editor, file_path])
    else:
        system = platform.system()
        if system == "Windows":
            # os.startfile only exists on Windows
            os.startfile(file_path)
        elif system == "Darwin":
            subprocess.call(["open", file_path])
        else:
            subprocess.call(["xdg-open", file_path])


def prompt_yes_no(question):
    while True:
        answer = input(f"{question} (y/n): ").strip().lower()
        if answer in ("y", "n"):
            return answer == "y"
        print(f"{answer} is an invalid choice, please select y/n")


def create_module_nix_file(name, file_path):
    content = module_template.format(name=name)
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
        "--dir",
        "-D",
        help="Put the module in /modules/{type}/{cata}/default.nix instead of /modules/{type}/{cata}/{name}.nix",
    )

    parser.add_argument(
        "--editor",
        "-E",
        action="store_true",
        help="Open default editor after module is created.",
    )

    args = parser.parse_args()

    root_dir = find_root_dir()
    if not root_dir:
        print("Error: Could not find flake.nix in any parent directory.")
        return

    if args.dir:
        file_path = os.path.join(root_dir, "modules", args.dir, f"{args.name}.nix")
    else:
        file_path = os.path.join(root_dir, "modules", f"{args.name}.nix")

    create_module_nix_file(args.name, file_path)
    print(f"Module created at: {file_path}")

    if prompt_yes_no("Open the module in your default editor?"):
        open_in_editor(file_path)


if __name__ == "__main__":
    main()
