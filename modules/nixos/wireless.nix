{
  flake.modules.nixos.wireless = { username, pkgs, ... }: {

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
}
