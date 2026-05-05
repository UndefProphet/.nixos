{
  flake.modules.nixos.networking = {
    lib,
    hostname,
    ...
  }: {
    networking = {
      hostName = hostname;
      firewall.enable = true;
      useDHCP = lib.mkForce true;

      networkmanager = {
        enable = true;
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
