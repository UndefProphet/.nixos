{
  flake.modules.nixos.ddcutil = { username, pkgs, ... }: {
    hardware.i2c.enable = true;
    users.users."${username}" = {
      packages = with pkgs; [ ddcutil ];
      extraGroups = [ "i2c" ];
    };
  };
}
