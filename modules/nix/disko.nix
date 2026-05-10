{
  inputs,
  lib,
  ...
}: {
  # https://github.com/nix-community/disko
  # Disc partitioning and declaration
  flake-file.inputs.disko = {
    type = "github";
    owner = "nix-community";
    repo = "disko";
    ref = "master";
  };

  imports = [
    inputs.disko.flakeModules.default
  ];
}
