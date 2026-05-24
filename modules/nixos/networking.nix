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

      networkmanager.enable = true;
    };
  };
}
