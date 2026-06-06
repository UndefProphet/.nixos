{
  flake.modules.nixos.grub= {

    boot.loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        efiInstallAsRemovable = true;
        useOSProber = true;
        gfxmodeEfi = "3440x1440";
        gfxmodeBios = "3440x1440";
        splashMode = "normal";
      };
    };
  };
}
