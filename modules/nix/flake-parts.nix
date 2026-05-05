{inputs, ...}: {
  flake-file.inputs = {
    # https://github.com/hercules-ci/flake-parts
    # flake-parts provides the options that represent standard flake attributes and establishes a way of working with system.
    flake-parts = {
      type = "github";
      owner = "hercules-ci";
      repo = "flake-parts";
    };

    # https://github.com/denful/import-tree
    # Recursively import Nix modules from a directory, with a simple, extensible API.
    import-tree = {
      type = "github";
      owner = "vic";
      repo = "import-tree";
    };
  };

  imports = [inputs.flake-parts.flakeModules.modules];

  debug = true;
  systems = [
    "aarch64-darwin"
    "aarch64-linux"
    "x86_64-darwin"
    "x86_64-linux"
  ];
  perSystem = {pkgs, ...}: {
    formatter = pkgs.alejandra;
  };
}
