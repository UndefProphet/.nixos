{

  flake-file.inputs = {

    hyprland = {
      type = "github";
      owner = "hyprwm";
      repo = "Hyprland";
      ref = "main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # hyprland-scroll-overview = {
    #   type = "github";
    #   owner = "yayuuu";
    #   repo = "hyprland-scroll-overview";
    #   ref = "main";
    #   # inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  flake.modules.nixos.hyprland-tty = {lib, config, ...}:{
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

  flake.modules.nixos.hyprland = {
    pkgs,
    lib,
    username,
    config,
    inputs',
    ...
    }:{

      imports = [
        ./_filechooser/yazi.nix
        ./_wallpaper-manager/waypaper.nix
      ];

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
}
