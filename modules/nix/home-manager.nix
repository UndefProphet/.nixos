{inputs, ...}: {
  # https://github.com/nix-community/home-manager
  # Provides a module system for managing a user environment.
  flake-file.inputs.home-manager = {
    type = "github";
    owner = "nix-community";
    repo = "home-manager";
    ref = "master";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.modules.nixos.home-manager = {
    lib,
    username,
    stateVersion,
    ...
  }: {
    imports = [
      inputs.home-manager.nixosModules.home-manager
      (lib.mkAliasOptionModule ["hm"] ["home-manager" "users" username])
    ];

    home-manager = {
      verbose = true;
      useUserPackages = true;
      useGlobalPkgs = true;
      backupFileExtension = "backup";
      backupCommand = "rm";
      overwriteBackup = true;
    };

    hm.home = {inherit stateVersion;};
  };
}
