{
  inputs,
  lib,
  ...
}: {
  imports = [inputs.flake-file.flakeModules.default];

  flake-file = {
    inputs = {flake-file.url = "github:vic/flake-file";};

    do-not-edit = "D o  N o t  E d i t o  O r  I  K i l l o  B i l l u !";
    outputs =
      /*
      nix
      */
      "inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} (inputs.import-tree ./modules)";
    description = "Potato";
  };
}
