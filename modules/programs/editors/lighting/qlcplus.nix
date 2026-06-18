{
  darwin.modules.gui = {
    homebrew.casks = [ "qlc+" ];
  };
  # homeManager.modules.gui =
  #   { pkgs, ... }:
  #   {
  #     home.packages = [
  #       (pkgs.qlcplus.overrideAttrs {
  #         nativeBuildInputs =
  #           with pkgs;
  #           [
  #             libsForQt5.qmake
  #             pkg-config
  #             libsForQt5.wrapQtAppsHook
  #           ]
  #           ++ lib.optionals stdenv.isLinux [
  #             udevCheckHook
  #           ];
  #         buildInputs =
  #           with pkgs;
  #           [
  #             libsForQt5.qtmultimedia
  #             libsForQt5.qtscript
  #             libsForQt5.qtserialport
  #             libsForQt5.qtwebsockets
  #             libftdi1
  #             libusb-compat-0_1
  #             libsndfile
  #             libmad
  #           ]
  #           ++ lib.optionals stdenv.isLinux [
  #             udev
  #             alsa-lib
  #             ola
  #           ]
  #           ++ lib.optionals stdenv.isDarwin [
  #             apple-sdk
  #             # darwin-specific deps go here
  #           ];
  #       })
  #     ];
  #   };
}
