{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations = let
    # stateVersion = lib.trivial.oldestSupportedRelease;
    stateVersion = "25.11";
    system = "x86_64-linux";
    configurationName = "desktop";

    nixos = "/dev/nvme0n1";
    home = "/dev/sda";
    swapSize = "32G";

    username = "tar";
    hostname = "deskman";
    homedir = "/home/${username}";
    configdir = "${homedir}/.nixos";
  in {
    desktop = inputs.nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit stateVersion;
        inherit username;
        inherit hostname;
        inherit homedir;
        inherit configdir;
        inherit configurationName;
      };

      modules = with self.modules.nixos; [
        # default
        nix
        desktop
        self.diskoConfigurations.default
        {
          _module.args = {
            inherit nixos;
            inherit home;
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

  #
  # flake.nixosConfigurations.laptop = mkNixosSystem {
  #   system = "x86_64-linux";
  #   hostName = "lapman";
  #   modules = with self.modules.nixos; [
  #     default
  #     laptop
  #     systemd-boot
  #   ];
  #   users = with self.modules.nixos; [
  #   ];
  # };
}
