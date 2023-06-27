{
  description = "Nix support for text-generation-webui";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/23.05";

    nix-init.url = "github:nix-community/nix-init";
    nix-init.inputs.nixpkgs.follows = "nixpkgs";

    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nix-init, treefmt-nix, ... }:

    let
      forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];
    in
    {
      packages = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages."${system}";
        in
        {
          default = pkgs.python3.pkgs.callPackage ./package.nix { };
        }
      );

      devShells = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages."${system}";
        in
        {
          default = pkgs.mkShell {
            packages = [
              nix-init.packages.${system}.default
            ];
          };
        }
      );

      formatter = forAllSystems (system:
        let
          pkgs = nixpkgs.legacyPackages."${system}";
        in
        treefmt-nix.lib.mkWrapper
          pkgs
          {
            projectRootFile = "flake.nix";
            programs.nixpkgs-fmt.enable = true;
          }
      );
    };
}
