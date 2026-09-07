{
  self,
  inputs,
  lib,
  ...
}:
let
  unwrap = module: builtins.head (module { }).imports;
  nixos-modules = lib.attrValues self.modules.nixos |> map unwrap;
in
{
  # Helper functions for creating system / home-manager configurations

  config.flake.lib = {
    mkNixosUserSystem =
      {
        system, # System type
        hostName, # System hostname
        stateVersion,
        username,
        homedir ? "/home/${username}",
        configuration ? { },
        extraModules ? [ ],
      }:
      inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          {
            _module.args = {
              inherit stateVersion;
              inherit username;
              inherit homedir;
            };
          }
          configuration
          { networking = lib.mkDefault { inherit hostName; }; }
          { system.stateVersion = lib.mkDefault stateVersion; }
        ]
        ++ nixos-modules
        ++ extraModules;
      };
  };
}
