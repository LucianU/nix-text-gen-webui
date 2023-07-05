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
      forAllLinux = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" ];
      forAllDarwin = nixpkgs.lib.genAttrs [ "aarch64-darwin" ];
      linuxPackages = forAllLinux (system:
        let
          pkgs = nixpkgs.legacyPackages."${system}";
        in
        {
          text-generation-webui-nvidia = pkgs.python3.pkgs.callPackage ./linux-nvidia.nix { };
          text-generation-webui-amd = pkgs.python3.pkgs.callPackage ./linux-amd.nix { };
        }
      );
      darwinPackages = forAllDarwin (system:
        let
          pkgs = nixpkgs.legacyPackages."${system}";
        in
        {
          text-generation-webui = pkgs.python3.pkgs.callPackage ./macos.nix { };
        }
      );
    in
    {
      packages = linuxPackages // darwinPackages;

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
