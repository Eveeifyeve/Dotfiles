{ lib
, fetchFromGitHub
, stdenvNoCC
, makeWrapper
, gh
, jq
}:
let
  binPath = lib.makeBinPath [
    gh
    jq
  ];
in
stdenvNoCC.mkDerivation {
  pname = "gh-combine-prs";
  version = "0-unstable-2024-04-24";

  src = fetchFromGitHub {
    owner = "rnorth";
    repo = "gh-combine-prs";
    rev = "ab066c1d810844c071a661301259cbb470891004";
    hash = "sha256-AgpNjeRz0RHf8D3ib7x1zixBxh32UUZJleub5W/suuM=";
  };

  nativeBuildInputs = [
    makeWrapper
  ];

  installPhase = ''
    install -D -m755 "gh-combine-prs" "$out/bin/gh-combine-prs"
  '';

  postFixup = ''
    wrapProgram "$out/bin/gh-combine-prs" --prefix PATH : "${binPath}"
  '';

  meta = with lib; {
    homepage = "https://github.com/rnorth/gh-combine-prs";
    description = "A `gh` extension for combining multiple PRs (e.g. Dependabot PRs) into one.";
    maintainers = with maintainers; [ eveeifyeve ];
    license = licenses.unlicense;
    mainProgram = "gh-notify";
    platforms = platforms.all;
  };
}