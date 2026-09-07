{
  flake.modules.nixos.virtualisation =
    {
      config,
      lib,
      pkgs,
      username,
      ...
    }:
    let
      cfg = config.conf.virtualisation.virtualisation;
    in
    {
      imports = [
        {
          options.conf.virtualisation.virtualisation = {
            enable = lib.mkEnableOption {
              default = false;
              description = "Enable virtualisation";
            };
          };
        }
      ];

      config = lib.mkIf cfg.enable {
        programs.virt-manager.enable = true;
        virtualisation.spiceUSBRedirection.enable = true;
        virtualisation.libvirtd = {
          enable = true;
          qemu = {
            package = pkgs.qemu_kvm;
            runAsRoot = true;
            swtpm.enable = true;
          };
        };
        users.extraUsers.${username}.extraGroups = [ "libvirtd" ];
      };
    };
}
