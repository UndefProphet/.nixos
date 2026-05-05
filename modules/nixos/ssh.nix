{
  flake.modules.nixos.ssh = {lib, ...}: {
    # SSH
    services.openssh = {
      enable = lib.mkDefault true;
      ports = [22];
      settings = {
        PasswordAuthentication = true;
        UseDns = true;
        # PermitRootLogin = "";
      };
    };
  };
}
