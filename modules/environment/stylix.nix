# TODO REMOVE Stylix and manage colorscheme manually
{ inputs, ... }: {
  # https://github.com/nix-community/stylix
  # Stylix is a theming framework for NixOS, Home Manager, nix-darwin, and Nix-on-Droid.
  tack.inputs.stylix = "gh:nix-community/stylix?ref=master";

  flake.modules.nixos.stylix =
    { pkgs, ... }:
    {
      imports = [
        inputs.stylix.nixosModules.stylix
      ];

      stylix = {
        enable = true;
        autoEnable = true;
        polarity = "dark";
        # base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest-dark-hard.yaml";
        base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";

        opacity =
          let
            opacity = 0.85;
          in
          {
            applications = opacity;
            desktop = opacity;
            terminal = opacity;
            popups = opacity;
          };

        icons = {
          enable = true;
          package = pkgs.papirus-icon-theme;
          dark = "Papirus-Dark";
          light = "Papirus-Light"; # Dark mode seems to not be used sometimes.
        };

        # cursor = {
        #   package = handofevil;
        #   name = "hand-of-evil";
        #   size = 24;
        # };

        fonts = {
          sizes =
            let
              size = 10.0;
            in
            {
              terminal = 9.0;
              # terminal     = size;
              applications = size;
              desktop = size;
              popups = size;
            };

          sansSerif = {
            # name = "Source Sans Pro";
            # package = pkgs.source-sans-pro;
            name = "JetBrainsMonoNL Nerd Font Mono";
            package = pkgs.nerd-fonts.jetbrains-mono;
          };

          serif = {
            # name = "Source Serif Pro";
            # package = pkgs.source-serif-pro;
            name = "JetBrainsMonoNL Nerd Font Mono";
            package = pkgs.nerd-fonts.jetbrains-mono;
          };

          monospace = {
            name = "JetBrainsMonoNL Nerd Font Mono";
            package = pkgs.nerd-fonts.jetbrains-mono;
            # name = "";
            # package = pkgs.roboto-mono
          };
        };

        targets = {
          # hyprland.enable = false;

          console.enable = true;
          spicetify.enable = false;
        };
      };

      hm.stylix.targets = {
        firefox = {
          profileNames = [
            "default"
            "streaming"
          ];
          colorTheme.enable = true;
        };

        zen-browser = {
          profileNames = [ "default" ];
        };

        # yazi.enable = false;
      };
    };
}
