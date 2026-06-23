{inputs,...}:{
  flake-file.inputs.nur = {
    url = "github:nix-community/NUR";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.modules.nixos.nur = {
    imports = [ inputs.nur.modules.nixos.default ];
  };
}
