{
  stdenv,
  gradle,
  jdk,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "java-project";
  version = "0.0.1";
  src = ./.;

  nativeBuildInputs = [
    jdk
    gradle
  ];

  mitmCache = gradle.fetchDeps {
    pkg = finalAttrs.finalPackage;
    data = ./deps.json;
  };

  __darwinAllowLocalNetworking = true;

})
