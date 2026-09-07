{
  description = "NixOS configuration";
  outputs =
    args@{ self, ... }:
    let

      # Tack as input manager with lazy evaluation
      inputs = (import ./inputs) { overrides = args.tackOverrides or { }; };
      self' = self // {
        inputs = inputs;
      }; # to make tack compatiable with flake-parts

      flakeLib = (import ./lib.nix) {
        inherit inputs;
        inherit (inputs.nixpkgs) lib;
        self = self';
      };

      lib = inputs.nixpkgs.lib // flakeLib.config.flake.lib;

    in
    inputs.flake-parts.lib.mkFlake
      {
        inherit inputs;
        self = self';
        specialArgs = {
          inherit lib;
        };
      }
      (
        inputs.import-tree [
          ./hosts # Hardware based configurations
          ./modules # Modules
          ./hjem # Hjem modules
        ]
      );
}
