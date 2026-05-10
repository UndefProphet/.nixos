{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations = let
    # stateVersion = lib.trivial.oldestSupportedRelease;
    stateVersion = "25.11";
    system = "x86_64-linux";
    
    nixos = "/dev/nvme0n1";
    swapSize = "16G";

    username = "tar";
    hostname = "lapman";
    homedir = "/home/${username}";
    configdir = "${homedir}/.nixos";
  in {
    laptop = inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit stateVersion;
        inherit username;
        inherit hostname;
        inherit homedir;
        inherit configdir;
      };

      modules = with self.modules.nixos; [
        # default
        nix
        laptop
        self.diskoConfigurations.default
        {
          _module.args = {
            inherit nixos;
            inherit swapSize;
          };
        }
        display-manager
        systemd-boot
        sudo-rs
        audio
        networking
        ssh
        secrets
        stylix

        # User
        user
        home-manager
        git
        terminal
        environment
        niri

        # Packages
        packages
        spotify
        thunderbird
        neomutt
        firefox
        obs
        yt-dlp
      ];
    };
  };
}
