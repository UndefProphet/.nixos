{inputs, ...}: {
  flake-file.inputs = {
    # You may not have these!
    nixos-credentials = {
      url = "git+ssh://git@github.com/UndefProphet/.nixos.credentials";
      flake = false;
    };

    # https://github.com/Mic92/sops-nix
    # Atomic, declarative, and reproducible secret provisioning for NixOS based on sops.
    sops-nix = {
      type = "github";
      owner = "Mic92";
      repo = "sops-nix";
      ref = "master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  flake.modules.nixos.secrets = {
    config,
    lib,
    ...
  }: {
    imports =
      [inputs.sops-nix.nixosModules.sops] ++ (lib.optional (inputs ? nixos-credentials) "${inputs.nixos-credentials}/secrets.nix");

    # Sops config
    sops = {
      defaultSopsFile = ./secrets/master.yaml;
      defaultSopsFormat = "yaml";
      age.keyFile = "${config.hm.home.homeDirectory}/.config/sops/age/keys.txt";
    };
  };
}
