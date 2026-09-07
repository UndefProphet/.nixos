{ lib, ... }:
{
  flake.modules.hjem-modules.hyprland =
    { config, pkgs, ... }:
    let
      cfg = config.windowManagers.hyprland;
    in
    {
      options.windowManagers.hyprland = {
        enable = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Enable the hyprland user configuration.";
        };
      };

      config = lib.mkIf cfg.enable {
        # # Dotfiles are relative to $HOME by default
        # files.".config/hypr/hyprland.conf".text = ''
        #   source=~/.config/hypr/monitors.conf
        # '';
        #
        # xdg.config.files."hypr/monitors.conf".text = ''
        #   monitor=,preferred,auto,1
        # '';
        #
        # packages = with pkgs; [ hyprpicker ];
        #
        # environment.sessionVariables = {
        #   MOZ_ENABLE_WAYLAND = "1";
        # };
      };
    };

  flake.modules.nixos.hyprland = { config, lib, ... }: {
    options.windowManagers.hyprland = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable hyprland system-wide.";
      };
    };

    config = lib.mkIf config.windowManagers.hyprland.enable {
      # Example system options
      # security.polkit.enable = true;
    };
  };
}
