{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.05";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system:
    let pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages.CircuitFlow = nixpkgs.lib.callPackageWith (pkgs // pkgs.lib // pkgs.haskellPackages) ./default.nix {};
    }
  );
}
