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
        laptop
        common
        self.diskoConfigurations.default
        {
          _module.args = {
            inherit nixos;
            inherit home;
            inherit swapSize;
          };
        }
        wireless
      ];
    });
  };
}
