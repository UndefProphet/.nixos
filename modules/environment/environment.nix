{ lib, ... }: {
  flake.modules.nixos.environment =
    { config, ... }:
    let
      cfg = config.conf.environment.environment;
    in
    {
      imports = [
        {
          options.conf.environment.environment = {
            enable = lib.mkEnableOption {
              default = false;
              description = "Enable environment configuration";
            };
          };
        }
      ];

      config = lib.mkIf cfg.enable {
        qt = {
          enable = true;
          # platformTheme = "qt5ct";
          # style = "kvantum";
        };

        security.polkit = {
          enable = true;
        };

        # TODO: remove these and add them to the keymaps for each WNM or keybinding software
        hm = {
        };
      };
    };
}
