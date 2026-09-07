{ inputs, ... }: {
  # https://github.com/nix-community/home-manager
  # Provides a module system for managing a user environment.
  tack.inputs.home-manager = "gh:nix-community/home-manager?ref=master";

  flake.modules.nixos.home-manager =
    {
      config,
      lib,
      username,
      stateVersion,
      ...
    }:
    let
      # cfg = config.conf.user.home-manager;
    in
    {
      imports = [
        # {
        #   options.conf.user.home-manager = {
        #     enable = lib.mkEnableOption {
        #       default = false;
        #       description = "Enable home-manager";
        #     };
        #   };
        # }
        inputs.home-manager.nixosModules.home-manager
        (lib.mkAliasOptionModule [ "hm" ] [ "home-manager" "users" username ])
      ];

      home-manager = {
        verbose = true;
        useUserPackages = true;
        useGlobalPkgs = true;
        backupFileExtension = "backup";
        backupCommand = "rm";
        overwriteBackup = true;
      };

      hm.home = { inherit stateVersion; };
    };
}
