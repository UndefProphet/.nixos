{ lib, ... }: {
  flake.modules.nixos.thunderbird =
    { config, ... }:
    let
      cfg = config.conf.packages.thunderbird;
    in
    {
      imports = [
        {
          options.conf.packages.thunderbird = {
            enable = lib.mkEnableOption {
              default = false;
              description = "Enable thunderbird";
            };
          };
        }
      ];

      config = lib.mkIf cfg.enable {
        hm.programs.thunderbird = {
          enable = true;
          profiles.default = {
            isDefault = true;
          };
        };
      };
    };
}
