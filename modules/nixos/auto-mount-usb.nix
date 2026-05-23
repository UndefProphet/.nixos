{
  flake.modules.nixos.auto-mount-usb = {username, ...}:{

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
}
