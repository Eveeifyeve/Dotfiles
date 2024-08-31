{ stdenv
, pname
, version
, meta
, fetchurl
, undmg
, lib
}:

stdenv.mkDerivation {
  inherit pname version;

  src = fetchurl {
    url = "https://curseforge.overwolf.com/downloads/curseforge-${version}.dmg";
    hash = "sha256-2nFqrUElzGnJsDyLBxMnaO9s4EaVQqDnSz3R+l+BfZU=";
  };

  nativeBuildInputs = [ undmg ];

  sourceRoot = ".";

  installPhase = ''
    runHook preInstall

    mkdir -p $out/Applications
    cp -r *.app $out/Applications

    runHook postInstall
  '';

  meta = meta // {
    maintainers = with lib.maintainers; [ Enzime ];
  };
}