{
  # Nix packages
  # A collection of over 100,000 software packages that can be installed with the Nix.
  flake-file.inputs.nixpkgs = {
    type = "github";
    owner = "nixos";
    repo = "nixpkgs";
    ref = "nixos-unstable";
  };

  flake.modules.nixos.nix = {stateVersion, ...}: {
    # Nix Config
    system = {inherit stateVersion;};
    nix = {
      optimise.automatic = true;
      settings = {
        max-jobs = "auto"; # how many builds at once
        cores = 0; # cores per build (0 = all available)
        auto-optimise-store = true;
        experimental-features = [
          "nix-command"
          "flakes"
        ];
      };
    };

    # Packages
    nixpkgs.config.allowBroken = false;
    nixpkgs.config.allowUnfree = true;
    environment.variables = {
      NIXPKGS_ALLOW_UNFREE = 1;
    }; # For nix-shell and other commands
  };
}
