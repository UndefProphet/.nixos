{ inputs, lib, ... }: {

  tack.inputs.nixos-core = "gh:manic-systems/nixos-core";

  flake.modules.nixos.rs-core =
    { config, ... }:
    let
      cfg = config.conf.system.rs-core;
    in
    {
      imports = [
        {
          options.conf.system.rs-core = {
            enable = lib.mkEnableOption {
              default = false;
              description = "Enable rs-core";
            };
          };
        }
        inputs.nixos-core.nixosModules.default
      ];

      config = lib.mkIf cfg.enable {
        system.nixos-core.enable = true;
      };
    };
}
