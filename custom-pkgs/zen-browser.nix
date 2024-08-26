{
  stdenv,
  fetchGithub,
  buildMozillaMach,
  nixosTests,
  lib,
}:
(buildMozillaMach rec {
  pname = "zen-browser";
  version = "1.0";

  src = fetchGithub {
    owner = "zen-browser";
    repo = "desktop";
    rev = version;
    hash = lib.fakeSha256;
  };

  meta = with lib; {
    description = "Experience tranquillity while browsing the web without people tracking you!";
    homepage = "https://github.com/zen-browser/desktop";
    license = licenses.mpl20;
    platforms = platforms.all;
    badPlatforms = platforms.linux; # TODO: test on linux
    mainProgram = "zen-browser";
  };

  tests = [ nixosTests.zen-browser ];

}).override
  ({
    # Moz config
  }).overrideAttrs
  (prev: {
    # Anything that modify's attrs like MOZ_DATA_REPORTING
  })
