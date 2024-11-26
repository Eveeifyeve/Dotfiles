{
  rustPlatform,
  lib,
  fetchFromGitHub,
  vimUtils,
  stdenv,
}:
let
  version = "2023-09-25";
  src = fetchFromGitHub {
    owner = "vyfor";
    repo = "cord.nvim";
    rev = "a26b00d58c42174aadf975917b49cec67650545f";
    hash = "sha256-jUxBvWnj0+axuw2SZ2zLzlhZS0tu+Bk8+wHtXENofkw=";
  };
  extension = if stdenv.isDarwin then "dylib" else "so";
  rustPackage = rustPlatform.buildRustPackage {
    pname = "cord.nvim-rust";
    inherit version src;

    cargoHash = "sha256-RS+0iLndye4U5eOoHLmwI+yxKAWS3JGHDbOK5jxf14Y=`";

    installPhase =
      let
        cargoTarget = stdenv.hostPlatform.rust.cargoShortTarget;
      in
      ''
        install -D target/${cargoTarget}/release/libcord.${extension} $out/lib/cord.${extension}
      '';
  };
in
vimUtils.buildVimPlugin {
  pname = "cord.nvim";
  inherit version src;

  nativeBuildInputs = [ rustPackage ];

  buildPhase = ''
    install -D ${rustPackage}/lib/cord.${extension} cord.${extension}
  '';

  installPhase = ''
    install -D cord $out/lua/cord.${extension}
  '';

  doInstallCheck = true;
  nvimRequireCheck = "cord";

  meta = {
    homepage = "https://github.com/vyfor/cord.nvim";
  };

}
