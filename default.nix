{ nixpkgs ? import <nixpkgs> {} }: with nixpkgs; {
	overlays = callPackage ./dt-overlays.nix {};
	modules = callPackage ./dt-modules.nix {};
}
