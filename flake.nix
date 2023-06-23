{
  description = "Nix support for text-generation-webui";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/23.05";
  };

  outputs = { self, nixpkgs }:

    let
      forAllSystems = nixpkgs.lib.genAttrs [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];
    in
      {
        packages = forAllSystems (system:
          let
            pkgs = nixpkgs.legacyPackages."${system}";
          in
            {
              text-generation-webui = pkgs.python3.pkgs.callPackage ./package.nix { };
            }
        );
      };
}
