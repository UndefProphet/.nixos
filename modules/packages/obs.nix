{
  flake.modules.nixos.obs = {pkgs, ...}: {
    programs.obs-studio = {
      enable = true;
      enableVirtualCamera = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-vaapi
        obs-teleport
        wlrobs
        droidcam-obs
      ];
    };

    networking.firewall = {
      # Teleport plugin
      allowedUDPPorts = [5678];
      allowedTCPPorts = [5678];
    };
  };
}
