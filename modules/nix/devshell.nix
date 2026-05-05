{
  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        nixd
        nil
        sops
      ];

      shellHook = ''
        alias sops="sops --config ./modules/secrets/.sops.yaml"
        alias sops-master="sops secrets/master.yaml"
        alias generate-flake="nix run .#write-flake";
      '';
    };
  };
}
