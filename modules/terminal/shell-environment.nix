{ lib, ... }: {
  flake.modules.nixos.shell-environment = { config, pkgs, ... }: {

    options.conf.terminal.shell-environment.enable = lib.mkEnableOption { };

    config =
      let
        cfg = config.conf.terminal.shell-environment;
      in
      lib.mkIf cfg.enable {

        hm = {

          programs.direnv = {
            enable = true;
            nix-direnv.enable = true;
          };

          programs.nh = {
            enable = true;
          };

          home.packages = [
            pkgs.isd
          ];

          xdg.terminal-exec = {
            enable = true;
            settings = {
              default = [
                "kitty.desktop"
              ];
            };
          };

          programs.btop.enable = true;

          programs.nix-your-shell.enable = true;
          programs.zoxide.enable = true;
          programs.lsd.enable = true;
          programs.starship = {
            enable = true;
            enableTransience = true;
          };
          programs.eza = {
            # package = pkgs.eza.overrideAttrs (o: {
            #   patches = (o.patches or [ ]) ++ [ ./_eza/custom-icons.patch ];
            #   doCheck = false;
            # });
            enable = true;
          };

          home.shellAliases = {
            # Vim to NVim
            v = "nvim";
            vi = "nvim";
            vim = "nvim";

            y = "yazi";

            # Utilities
            # disks = lib.getExe pkgs.disktui;
            # audio = lib.getExe pkgs.wiremix;
            # music = lib.getExe pkgs.cliamp;
            # wifi = lib.getExe pkgs.impala;

            # Improvements
            # ls = "lsd -lhFXN";
            open = "xdg-open";
            cat = "${pkgs.bat}/bin/bat";
            cd = "z"; # Zoxide alias
          };
        };
      };

  };
}
