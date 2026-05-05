{
  self,
  inputs,
  lib,
  ...
}: {
  # Helper functions for creating system / home-manager configurations

  config.flake.lib = {
    mkNixosSystem = {
      system, # System type
      hostName, # System hostname
      modules ? [], # Modules for system
      users ? [],
      configuration ? {}, # Additional configuration to nixosSystem
    }:
      inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        modules =
          modules
          ++ users
          ++ [
            {networking = {inherit hostName;};}
          ];
      }
      // configuration;
  };
}
