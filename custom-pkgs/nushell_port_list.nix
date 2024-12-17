{
  lib,
  rustPlatform,
  fetchFromGitHub,
  stdenv,
  nix-update-script,
}:

rustPlatform.buildRustPackage rec {
  pname = "nushell_plugin_port_list";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "FMotalleb";
    repo = "nu_plugin_port_list";
    rev = "a53277429a39aff7afbbae2562e10ed24d62b132";
    hash = "sha256-Ihcg7ped7tuIYrg0/zpqp/ruGvkoOY1QUM+P2Pb30GY=";
  };

  cargoHash = "sha256-2RvgXzd4qKxNl1o0sNdJFqhbGaPOkHvw+0lfLf6ceZA=";

  nativeBuildInputs = [ rustPlatform.bindgenHook ];

  buildInputs =
    lib.optionals stdenv.hostPlatform.isDarwin
      [
      ];

  passthru.updateScript = nix-update-script { };

  meta = with lib; {
    description = "Nushell plugin to display all active network connections";
    homepage = "https://github.com/FMotalleb/nu_plugin_port_list";
    license = licenses.mit;
    maintainers = with maintainers; [ eveeifyeve ];
    mainProgram = "nu_plugin_port_list";
  };
}
