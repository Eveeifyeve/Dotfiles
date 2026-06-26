{
  bluej,
  fetchurl,
  openjdk8,
  gtk3,
  unzip, # Make sure unzip is available to unpack the jar
  ...
}:

bluej.overrideAttrs {
  version = "3.1.7";
  src = fetchurl {
    url = "https://www.bluej.org/download/files/bluej-317.jar";
    sha256 = "sha256-/HDxvd1nbDkdlgVxobvJ8z6mC1httfxDQok370GUoVE=";
  };

  nativeBuildInputs = [ unzip ];

  # Overriding unpackPhase because Nix needs to know how to extract a raw .jar file
  unpackPhase = ''
    mkdir source
    cd source
    unzip $src
  '';

  installPhase = ''
    runHook preInstall

    # Create the target directory
    mkdir -p $out/lib/bluej

    # Copy the unzipped contents into the output directory
    cp -r * $out/lib/bluej/

    # Handle icons
    mkdir -p $out/share/icons/hicolor/{16x16,32x32,48x48,64x64,128x128,256x256}/apps
    for dimension in 16x16 32x32 48x48 64x64 128x128 256x256; do
      # Using a conditional in case the icon path inside the jar is slightly different
      if [ -f ./icons/bluej-icon-512-embossed.png ]; then
        magick ./icons/bluej-icon-512-embossed.png -geometry $dimension $out/share/icons/hicolor/$dimension/apps/bluej.png
      fi
    done

    # Create the wrapper pointing to the absolute path of boot.jar in the nix store
    makeWrapper ${openjdk8}/bin/java $out/bin/bluej \
      "''${gappsWrapperArgs[@]}" \
      --suffix XDG_DATA_DIRS : "${gtk3}/share/gsettings-schemas/${gtk3.name}" \
      --add-flags "-Dawt.useSystemAAFontSettings=on -cp $out/lib/bluej/bluej.jar:$out/lib/bluej/boot.jar bluej.Boot"

    runHook postInstall
  '';
}
