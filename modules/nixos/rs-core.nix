{inputs, ...}:{

  flake-file.inputs.nixos-core = {
    type = "github";
    owner = "manic-systems";
    repo = "nixos-core";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.modules.nixos.rs-core = {
    imports = [ inputs.nixos-core.nixosModules.default ];
    system.nixos-core.enable = true;
  };
}
