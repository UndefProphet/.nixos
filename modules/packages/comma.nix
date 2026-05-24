{inputs, ...}: {
  # https://github.com/nix-community/nix-index
  # A files database for nixpkgs
  flake-file.inputs.nix-index-database = {
    type = "github";
    owner = "nix-community";
    repo = "nix-index-database";
    ref = "main";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.modules.nixos.comma= {
    hm = {
      imports = [inputs.nix-index-database.homeModules.default];
      programs.nix-index-database.comma.enable = true;
    };
  };
}
