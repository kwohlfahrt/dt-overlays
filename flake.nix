{
  description = "Raspberry Pi device-tree overlays";

  inputs = {
    nixpkgs.url = "nixpkgs";
  };

  outputs = { self, nixpkgs, } : let
    systems = [ "aarch64-linux" ];
    forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);
    nixpkgsFor = system: import nixpkgs { inherit system; };
  in {
    overlay = self: super: {
      dt-overlays = self.callPackage ./dt-overlays.nix {};
      dt-modules = self.callPackage ./dt-modules.nix {};
    };

    packages = forAllSystems (system: let
      pkgs = nixpkgsFor system;
    in {
      overlays = pkgs.callPackage ./dt-overlays.nix {};
      modules = pkgs.callPackage ./dt-modules.nix {};
    });
  };
}

