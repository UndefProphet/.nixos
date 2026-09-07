{
  flake.modules.nixos.display-manager =
    {
      config,
      lib,
      pkgs,
      username,
      ...
    }:
    let
      cfg = config.conf.greeter.display-manager;
    in
    {
      imports = [
        {
          options.conf.greeter.display-manager = {
            enable = lib.mkEnableOption {
              default = false;
              description = "Enable display manager";
            };
          };
        }
      ];

      config = lib.mkIf cfg.enable {
        services.greetd = {
          enable = true;
          useTextGreeter = true;
          settings = {
            default_session = {
              # command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --remember-session";
              command = lib.concatStringsSep " " [
                "${pkgs.greetd.tuigreet}/bin/tuigreet"
                # Behaviour
                "--remember --remember-session" # Remember username and session

                # Theme
                "--time"
                "--greeting 'Hello bitch'"
                "--asterisks"
                "border=magenta';'text=cyan';'prompt=green';'time=red';'action=blue';'button=yellow';'container=black';'input=red"
              ];
              user = username;
            };
          };
        };
      };
    };
}
