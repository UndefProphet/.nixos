{
  perSystem = {
    pkgs,
    lib,
    inputs',
    ...
  }: {
    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        nixd
        nil
        sops
        inputs'.tack.packages.default
      ];

      shellHook = ''
      '';
    };
  };
}
