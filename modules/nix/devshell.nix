{
  perSystem =
    {
      pkgs,
      lib,
      inputs',
      ...
    }:
    {

      formatter = pkgs.nixfmt-tree;

      devShells.default = pkgs.mkShell {
        packages = with pkgs; [
          nixd
          nil
          sops
          inputs'.tack.packages.default
        ];

        shellHook = "";
      };
    };
}
