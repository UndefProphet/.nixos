{
  flake.modules.nixos.ddcutil =
    {
      config,
      lib,
      username,
      pkgs,
      ...
    }:
    let
      cfg = config.conf.hardware.ddcutil;
    in
    {
      imports = [
        {
          options.conf.hardware.ddcutil = {
            enable = lib.mkEnableOption {
              default = false;
              description = "Enable ddcutil";
            };
          };
        }
      ];

      config = lib.mkIf cfg.enable {
        hardware.i2c.enable = true;
        users.users."${username}" = {
          packages = with pkgs; [ ddcutil ];
          extraGroups = [ "i2c" ];
        };
      };
    };
}
