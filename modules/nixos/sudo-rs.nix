{
  flake.modules.nixos.sudo-rs = {
    security = {
      sudo.enable = false;
      sudo-rs = {
        enable = true;
        wheelNeedsPassword = true;
        execWheelOnly = true;
        extraConfig = ''
          Defaults pwfeedback
        '';
      };
    };
  };
}
