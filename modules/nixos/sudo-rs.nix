{ lib, ... }: {
  flake.modules.nixos.sudo-rs =
    { config, ... }:
    let
      cfg = config.conf.security.sudo-rs;
    in
    {
      imports = [
        {
          options.conf.security.sudo-rs = {
            enable = lib.mkEnableOption {
              default = false;
              description = "Enable sudo-rs";
            };
          };
        }
      ];

      config = lib.mkIf cfg.enable {
        security = {
          sudo.enable = false;
          sudo-rs = {
            enable = true;
            wheelNeedsPassword = true;
            execWheelOnly = true;
            extraConfig = ''
              Defaults pwfeedback
            '';
          };
        };
      };
    };
}
