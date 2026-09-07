{
  flake.modules.nixos.auto-mount-usb =
    {
      config,
      lib,
      username,
      ...
    }:
    let
      cfg = config.conf.hardware.auto-mount-usb;
    in
    {
      imports = [
        {
          options.conf.hardware.auto-mount-usb = {
            enable = lib.mkEnableOption {
              default = false;
              description = "Enable auto-mounting USB drives";
            };
          };
        }
      ];

      config = lib.mkIf cfg.enable {
        services.gvfs.enable = true;

        hm = {
          services.udiskie = {
            enable = true;
            automount = true;
            tray = "auto";
            notify = true;
            settings = {
              program_options = {
                file_manager = "xdg-open";
              };
            };
          };

          systemd.user.tmpfiles.rules = [
            "L+ /home/${username}/disks - - - - /run/media/${username}"
          ];
        };
      };
    };
}
