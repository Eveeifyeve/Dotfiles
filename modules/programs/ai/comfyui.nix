{ lib, ... }:
{
  homeManager.modules.gui =
    { pkgs, ... }:
    let
      comfyui-pr-drv = pkgs.applyPatches {
        src = pkgs.path;
        patches = [
          (pkgs.fetchpatch2 {
            url = "https://github.com/NixOS/nixpkgs/compare/8141b9774ade981b29389633069d6752e164dca0...b0661927bef41ec2fac7f18cfcf03cb0299f8cdc.patch";
            hash = "sha256-XMzD784H6AbQSqstEGWVVhXC4C70zS3sehJmxq4d28o=";
          })
        ];
      };

      comfyui-pr = import comfyui-pr-drv { inherit (pkgs) system; };
    in
    lib.mkIf pkgs.stdenv.isLinux {
      home.packages = [ comfyui-pr.comfyui ];
    };

  # nixos.modules.gui =
  #   { pkgs, ... }:
  #   {
  #     imports = [ inputs.nix-comfyui.nixosModules.default ];
  #     nix.settings = {
  #       substituters = [ "https://comfyui.cachix.org" ];
  #       trusted-public-keys = [ "comfyui.cachix.org-1:33mf9VzoIjzVbp0zwj+fT51HG0y31ZTK3nzYZAX0rec=" ];
  #     };
  #
  #     services.comfyui = {
  #       enable = true;
  #       gpuSupport = lib.mkIf pkgs.config.cudaSupport "cuda" ++ lib.mkIf pkgs.config.rocmSupport "amd";
  #     };
  #   };
}
