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

    in
    inputs.flake-parts.lib.mkFlake
      {
        inherit inputs;
        self = self';
      }
      (
        inputs.import-tree [
          ./hosts # Hardware based configurations
          ./modules # Modules
        ]
      );
}
