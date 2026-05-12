{
  flake.modules.nixos.grub= {

    boot.loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        gfxmodeEfi = "3440x1440";
        gfxmodeBios = "3440x1440";
        splashMode = "normal";
      };
    };


    # boot = {
    #   initrd.systemd.enable = false; # Required for swapfile hibernationpep
    #   loader = {
    #     efi.canTouchEfiVariables = true;
    #     systemd-boot.enable = true;
    #   };
    # };
  };
}
