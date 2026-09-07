{ lib, ... }: {
  flake.modules.nixos.git =
    { config, ... }:
    let
      cfg = config.conf.terminal.git;
    in
    {
      imports = [
        {
          options.conf.terminal.git = {
            enable = lib.mkEnableOption {
              default = false;
              description = "Enable git and ssh-agent";
            };
          };
        }
      ];

      config = lib.mkIf cfg.enable {
        # Home manager
        hm = {
          programs.git = {
            enable = true;
          };

          services.ssh-agent = {
            enable = true;
          };
        };
      };
    };
}
