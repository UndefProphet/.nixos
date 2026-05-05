{
  flake.modules.nixos.display-manager = {
    lib,
    pkgs,
    username,
    ...
  }: {
    # Boot animation
    boot = {
      initrd.systemd.enable = true;
      # plymouth = {
      #   enable = false;
      #   theme = lib.mkForce "default";
      #   themePackages = [ myCustomPlymouthTheme ];
      # };
      # Enable "Silent boot"
      consoleLogLevel = 7;
      initrd.verbose = true;

      # Implment logs ontop of the plymouth animation
      kernelParams = [
        "quiet"
        "splash"
        "boot.shell_on_fail"
        "udev.log_priority=3"
        "rd.systemd.show_status=auto"
      ];
    };

    services.rsyslogd.enable = true;

    services.greetd = {
      enable = true;
      useTextGreeter = true;
      settings = {
        default_session = {
          # command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --remember-session";
          command = lib.concatStringsSep " " [
            "${pkgs.greetd.tuigreet}/bin/tuigreet"
            # Behaviour
            "--remember --remember-session" # Remember username and session

            # Theme
            "--time"
            "--greeting 'Hello bitch'"
            "--asterisks"
            "border=magenta';'text=cyan';'prompt=green';'time=red';'action=blue';'button=yellow';'container=black';'input=red"
          ];
          user = username;
        };
      };
    };
  };
}
