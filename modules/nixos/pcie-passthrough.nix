{
  flake.modules.nixos.gpu-passthrough =
    {
      config,
      lib,
      ids,
      ...
    }:
    let
      cfg = config.conf.virtualisation.gpu-passthrough;
    in
    {
      imports = [
        {
          options.conf.virtualisation.gpu-passthrough = {
            enable = lib.mkEnableOption {
              default = false;
              description = "Enable GPU passthrough";
            };
          };
        }
      ];

      config = lib.mkIf cfg.enable {
        boot.initrd.kernelModules = [
          "vfio_pci"
          "vfio"
          "vfio_iommu_type1"

          "amdgpu"

          # "radeon"
          # "nouveau"
        ];

        boot.kernelParams = [
          "amd_iommu=on"
          "vfio-pci.ids=${builtins.concatStringsSep "," ids}"
        ];
      };
    };
}
