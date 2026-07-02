{
  rustPlatform,
  cargo-tauri,
  lib,
}:
let
  cargoToml = lib.importTOML ./Cargo.toml;
in
rustPlatform.buildRustPackage {
  pname = cargoToml.name;
  inherit (cargoToml) version;

  src = ./.;

  cargoLock = {
    lockFile = ./Cargo.lock;
    allowBuiltinFetchGit = true;
  };

  nativeBuildInputs = [
    cargo-tauri.hook
    # Setup your frontend packages..
  ];
}
