{
  self,
  inputs,
  withSystem,
  ...
}: {
  flake.nixosConfigurations = let
    # stateVersion = lib.trivial.oldestSupportedRelease;
    stateVersion = "25.11";
    system = "x86_64-linux";
    configurationName = "laptop";

    nixos = "/dev/nvme0n1";
    home = null;
    swapSize = "16G";

    username = "tar";
    hostname = "lapman";
    homedir = "/home/${username}";
    configdir = "${homedir}/.nixos";
  in {
    laptop = withSystem "x86_64-linux" ({self', inputs', ...}: inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit stateVersion;
        inherit username;
        inherit hostname;
        inherit homedir;
        inherit configdir;
        inherit configurationName;
        inherit self';
        inherit inputs';
      };

      modules = with self.modules.nixos; [
        # default
        nix
        laptop
        self.diskoConfigurations.default
        {
          _module.args = {
            inherit nixos;
            inherit home;
            inherit swapSize;
          };
        }
        display-manager
        grub
        rs-core
        sudo-rs
        audio
        networking
        wireless
        ssh
        secrets

        # Nixos
        stylix
        auto-mount-usb

        # User
        user
        home-manager
        git
        terminal
        environment
        hyprland

        {
          services.tailscale = {
            enable = true;
          };
        }

        # Packages
        packages-nix-utilities
        packages-wayland
        packages-generic
        packages-creative
      ];
    });
  };
}
