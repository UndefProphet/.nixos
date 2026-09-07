{
  flake.modules.nixos.networking =
    {
      config,
      lib,
      hostname,
      ...
    }:
    let
      cfg = config.conf.networking.networking;
    in
    {
      imports = [
        {
          options.conf.networking.networking = {
            enable = lib.mkEnableOption {
              default = false;
              description = "Enable networking configuration";
            };
          };
        }
      ];

      config = lib.mkIf cfg.enable {
        networking = {
          hostName = hostname;
          firewall.enable = true;
          useDHCP = lib.mkForce true;

          networkmanager.enable = true;
        };
      };
    };
}
