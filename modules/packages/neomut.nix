{ lib, ... }: {
  flake.modules.nixos.neomutt =
    { config, ... }:
    let
      cfg = config.conf.packages.neomutt;
    in
    {
      imports = [
        {
          options.conf.packages.neomutt = {
            enable = lib.mkEnableOption {
              default = false;
              description = "Enable neomutt";
            };
          };
        }
      ];

      config = lib.mkIf cfg.enable {
        hm.programs.neomutt = {
          enable = true;
          vimKeys = true;
        };
      };
    };
}
