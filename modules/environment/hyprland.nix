{

  tack.inputs = {
    hyprland = "gh:hyprwm/Hyprland?ref=main";
    fetch = {
      hypr-plugs = "gh:hyprwm/hyprland-plugins";
      scroll-overview = "gh:yayuuu/hyprland-scroll-overview";
    };
  };

  flake.modules.nixos.hyprland-tty =
    { lib, config, ... }:
    let
      cfg = config.conf.windowManagers.hyprland-tty;
    in
    {
      imports = [
        {
          options.conf.windowManagers.hyprland-tty = {
            enable = lib.mkEnableOption {
              default = false;
              description = "Enable automatic hyprland session on tty1";
            };
          };
        }
      ];

      config = lib.mkIf cfg.enable {

        environment.loginShellInit =
          let
            session =
              # bash
              if config.programs.hyprland.withUWSM then
                "exec uwsm start hyprland-uwsm.desktop"
              else
                lib.getExe config.programs.hyprland.package;
          in
          lib.mkOrder 0 /* bash */ ''
            # [[ $- != *i* ]] && return
            # interactive-only commands here
              # case $- in
              #   *i*) ;;
              #   *) return ;;
              # esac

              # Auto start wayland session on tty1
              if [[ $(tty) == '/dev/tty1' ]]; then
                ${session}
              else
                echo "failed"
              fi
          '';
      };
    };

  flake.modules.nixos.hyprland =
    {
      pkgs,
      lib,
      username,
      config,
      inputs',
      ...
    }:
    let
      cfg = config.conf.windowManagers.hyprland;
    in
    {
      options.conf.windowManagers.hyprland = {
        enable = lib.mkEnableOption {
          default = false;
          description = "Enable hyprland";
        };
      };

      imports = [
        ./_filechooser/yazi.nix
        ./_wallpaper-manager/waypaper.nix
      ];

      config = lib.mkIf cfg.enable {
        programs.hyprland = {
          enable = true;
          xwayland.enable = true;
          portalPackage = inputs'.hyprland.packages.xdg-desktop-portal-hyprland;
          package = inputs'.hyprland.packages.hyprland;
          withUWSM = true;
        };

        users.users."${username}".packages = with pkgs; [
          kanshi
        ];

        hm = {
          programs.vicinae.enable = true;
          services.dunst = {
            enable = true;
            settings = {
              global = {
                origin = "top-center";
                # offset = "(480, 30)";
              };
            };
          };
          services.hyprpolkitagent.enable = true;

          wayland.windowManager.hyprland = {
            enable = config.programs.hyprland.enable;
            package = config.programs.hyprland.package;
            portalPackage = config.programs.hyprland.portalPackage;

            # plugins = [
            #   inputs'.hyprland-scroll-overview.packages.scrolloverview
            # ];
          };
        };
      };
    };
}
