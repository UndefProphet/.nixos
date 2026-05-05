{
  flake.modules.nixos.systemd-boot = {
    boot = {
      initrd.systemd.enable = true; # Required for swapfile hibernationpep
      loader = {
        efi.canTouchEfiVariables = true;
        systemd-boot.enable = true;
      };
    };
  };
}
