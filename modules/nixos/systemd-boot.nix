{ lib, ... }: {
  flake.modules.nixos.systemd-boot =
    { config, ... }:
    let
      cfg = config.conf.boot.systemd-boot;
    in
    {
      imports = [
        {
          options.conf.boot.systemd-boot = {
            enable = lib.mkEnableOption {
              default = false;
              description = "Enable systemd-boot bootloader";
            };
          };
        }
      ];

      config = lib.mkIf cfg.enable {
        boot = {
          loader = {
            efi.canTouchEfiVariables = true;
            systemd-boot.enable = true;
          };
        };
      };
    };
}
