{
  self,
  inputs,
  lib,
  ...
}:
let
  unwrap = module: builtins.head (module { }).imports;
  # Modules whose imports already aggregate other modules; including them in
  # nixos-modules alongside the individual modules would double-import every
  # leaf and fail with "option is already declared".
  excluded = [ "common" ];
  nixos-modules =
    let
      mods = self.modules.nixos;
      include = name: !builtins.elem name excluded;
    in
    lib.attrNames mods |> lib.filter include |> map (name: unwrap mods.${name});
in
{
  # Helper functions for creating system / home-manager configurations

  config.flake.lib = {
    mkNixosUserSystem =
      {
        system, # System type
        hostName, # System hostname
        configurationName,
        stateVersion,
        username,
        homedir ? "/home/${username}",
        configdir ? "/home/${username}/.nixos",
        configuration ? { },
        extraModules ? [ ],
      }:
      inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          {
            _module.args = {
              inherit
                stateVersion
                configurationName
                username
                homedir
                configdir
                ;
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
