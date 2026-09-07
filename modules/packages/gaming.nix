{ lib, ... }: {
  flake.modules.nixos.gaming =
    { config, ... }:
    let
      cfg = config.conf.packages.gaming;
    in
    {
      imports = [
        {
          options.conf.packages.gaming = {
            enable = lib.mkEnableOption {
              default = false;
              description = "Enable gaming";
            };
          };
        }
      ];

      config = lib.mkIf cfg.enable {
        programs.steam = {
          enable = true;
          protontricks.enable = true;
        };
      };
    };
}
