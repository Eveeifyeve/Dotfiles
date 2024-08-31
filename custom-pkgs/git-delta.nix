{
  lib,
  rustPlatform,
  fetchFromGitHub,
  installShellFiles,
  pkg-config,
  oniguruma,
  stdenv,
  darwin,
  git,
}:

rustPlatform.buildRustPackage rec {
  pname = "delta";
  version = "0.18.0";

  src = fetchFromGitHub {
    owner = "dandavison";
    repo = "delta";
    rev = "refs/tags/${version}";
    hash = "sha256-1UOVRAceZ4QlwrHWqN7YI2bMyuhwLnxJWpfyaHNNLYg=";
  };

  cargoHash = "sha256-/h7djtaTm799gjNrC6vKulwwuvrTHjlsEXbK2lDH+rc=";

  nativeBuildInputs = [
    installShellFiles
    pkg-config
  ];

  buildInputs = [
    oniguruma
  ] ++ lib.optionals stdenv.isDarwin [ darwin.apple_sdk_11_0.frameworks.Foundation ];

  nativeCheckInputs = [ git ];

  env = {
    RUSTONIG_SYSTEM_LIBONIG = true;
  };

  postInstall = ''
    installShellCompletion --cmd delta \
      etc/completion/completion.{bash,fish,zsh}
  '';

  dontUseCargoParallelTests = true;

  checkFlags = lib.optionals stdenv.isDarwin [ "--skip=test_diff_same_non_empty_file" ];

  meta = with lib; {
    homepage = "https://github.com/dandavison/delta";
    description = "Syntax-highlighting pager for git";
    changelog = "https://github.com/dandavison/delta/releases/tag/${version}";
    license = licenses.mit;
    maintainers = with maintainers; [
      zowoq
      SuperSandro2000
      figsoda
    ];
    mainProgram = "delta";
  };
}