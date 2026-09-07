{
  flake.modules.nixos.wireless =
    {
      config,
      lib,
      username,
      pkgs,
      ...
    }:
    let
      cfg = config.conf.networking.wireless;
    in
    {
      imports = [
        {
          options.conf.networking.wireless = {
            enable = lib.mkEnableOption {
              default = false;
              description = "Enable wireless";
            };
          };
        }
      ];

      config = lib.mkIf cfg.enable {
        users.users."${username}".packages = with pkgs; [
          impala
        ];

        networking = {
          networkmanager = {
            # wifi.backend = "iwd";
            wifi.powersave = true;
          };

          wireless = {
            enable = true;
            # enable = false;
            # iwd = {
            #   enable = true;
            #   settings = {
            #     General.EnableNetworkConfiguration = true;
            #     Network = {
            #       EnableIPv6 = true;
            #       RoutePriorityOffset = 300;
            #     };
            #   };
            # };
          };
        };
      };
    };
}
