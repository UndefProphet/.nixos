{ inputs, ... }: {
  # https://github.com/Gerg-L/spicetify-nix
  # A themebale spotify client
  tack.inputs.spicetify-nix = "gh:Gerg-L/spicetify-nix?ref=master";

  flake.modules.nixos.spotify =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      cfg = config.conf.packages.spotify;
    in
    {
      imports = [
        {
          options.conf.packages.spotify = {
            enable = lib.mkEnableOption {
              default = false;
              description = "Enable spotify";
            };
          };
        }
      ];

      config = lib.mkIf cfg.enable {
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
    };
}
