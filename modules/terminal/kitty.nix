{ lib, ... }: {
  flake.modules.nixos.kitty =
    {
      config,
      ...
    }:
    let
      cfg = config.conf.terminal.kitty;
    in
    {
      options.conf.terminal.kitty.enable = lib.mkEnableOption {
        description = "Enable fish shell";
      };

      config = lib.mkIf cfg.enable {
        hm.programs.kitty = {
          enable = true;
          settings = {
            window_padding_width = 10;
            confirm_os_window_close = 0;
          };
        };
      };
    };
}
