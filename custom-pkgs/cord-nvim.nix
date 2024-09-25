{rustPlatform, lib, fetchFromGithub, vimUtils, stdenv}:
let
version = "2023-09-25";
src = fetchFromGithub {
	owner = "eveeifyeve";
	repo = "cord.nvim";
	rev = "876e036619a8d7c4dc90f2d4611fc3e23a08a05b";
	hash = lib.fakeHash;
};
extension = if stdenv.isDarwin then "dylib" else "so";
rustPackage = rustPlatform.buildRustPackage {
	pname = "cord.nvim-rust";
	inherit version src;

	cargoHash = "sha256-6FYf4pHEPxvhKHHPmkjQ40zPxaiypnpDxF8kNH+h+tg=";

	installPhase = let
		cargoTarget = stdenv.hostPlatform.rust.cargoShortTarget;
	in ''
		install -D target/${cargoTarget}/release/libcord.${extension} $out/lib/cord.${extension}
	'';
};
in 
vimUtils.buildVimPlugin {
	pname = "cord.nvim";
	inherit version src;

	nativeBuildInputs = [
		rustPackage
	];

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
