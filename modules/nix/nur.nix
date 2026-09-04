{ inputs, ... }: {
  tack.inputs.nur = "gh:nix-community/NUR?ref=master";

  flake.modules.nixos.nur = {
    imports = [ inputs.nur.modules.nixos.default ];
  };
}
