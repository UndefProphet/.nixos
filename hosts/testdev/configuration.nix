{
  lib,
  inputs,
  self,
  ...
}:
{
  flake.nixosConfigurations = {
    lap = lib.mkNixosUserSystem {
      configurationName = "lap";
      system = "x86_64-linux";
      stateVersion = "25.11";
      hostName = "lap";
      username = "tar";

      configuration = {
        conf = {
          boot.grub.enable = true;
          terminal = {
            terminal.enable = true;
            git.enable = true;
          };
        };
      };

      extraModules = [
        (import ./_disko.nix { inherit inputs; }).flake.modules.nixos.lap
        (import ./_hardware.nix { inherit lib; }).flake.modules.nixos.lap
      ];
    };
  };
}
