{
  flake.modules.nixos.ssh =
    { config, lib, ... }:
    let
      cfg = config.conf.networking.ssh;
    in
    {
      imports = [
        {
          options.conf.networking.ssh = {
            enable = lib.mkEnableOption {
              default = false;
              description = "Enable SSH server";
            };
          };
        }
      ];

      config = lib.mkIf cfg.enable {
        # SSH
        services.openssh = {
          enable = lib.mkDefault true;
          ports = [ 22 ];
          settings = {
            UseDns = true;
            PasswordAuthentication = false; # Disables password logins
            KbdInteractiveAuthentication = false; # Disables keyboard-interactive/PAM passwords
            PermitRootLogin = "prohibit-password"; # Prevents root login with passwords
          };
        };
      };
    };
}
