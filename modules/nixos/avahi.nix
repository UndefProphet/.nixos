{ lib, ... }: {
  flake.modules.nixos.avahi =
    { config, ... }:
    let
      cfg = config.conf.networking.avahi;
    in
    {
      imports = [
        {
          options.conf.networking.avahi = {
            enable = lib.mkEnableOption {
              default = false;
              description = "Enable avahi";
            };
          };
        }
      ];

      config = lib.mkIf cfg.enable {
        services.avahi = {
          enable = true;
        };
      };
    };
}
