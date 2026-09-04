{ inputs, ... }: {
  # https://github.com/Gerg-L/spicetify-nix
  # A themebale spotify client
  tack.inputs.spicetify-nix = "gh:Gerg-L/spicetify-nix?ref=master";

  flake.modules.nixos.spotify = { pkgs, ... }: {
    hm = {
      imports = [
        inputs.spicetify-nix.homeManagerModules.spicetify
      ];

      programs = {
        spicetify =
          let
            spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
          in
          {
            enable = true;
            # theme = spicePkgs.themes.text // { };
          };
      };
    };
  };
}
