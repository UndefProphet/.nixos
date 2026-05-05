{inputs, ...}: {
  # https://github.com/Gerg-L/spicetify-nix
  # A themebale spotify client
  flake-file.inputs.spicetify-nix = {
    type = "github";
    owner = "Gerg-L";
    repo = "spicetify-nix";
    ref = "master";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.modules.nixos.spotify = {pkgs, ...}: {
    hm = {
      imports = [
        inputs.spicetify-nix.homeManagerModules.spicetify
      ];

      programs = {
        spicetify = let
          spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
        in {
          enable = true;
          # theme = spicePkgs.themes.text // { };
        };
      };
    };
  };
}
