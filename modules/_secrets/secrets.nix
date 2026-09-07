{ inputs, lib, ... }: {
  tack.inputs = {
    # You may not have these!
    fetch.nixos-credentials = "git+ssh://git@github.com/UndefProphet/.nixos.credentials";

    # https://github.com/Mic92/sops-nix
    # Atomic, declarative, and reproducible secret provisioning for NixOS based on sops.
    sops-nix = "gh:Mic92/sops-nix?ref=master";
  };

  flake.modules.nixos.secrets =
    {
      config,
      lib,
      ...
    }:
    let
      cfg = config.conf.security.secrets;
    in
    {
      imports = [
        {
          options.conf.security.secrets = {
            enable = lib.mkEnableOption {
              default = false;
              description = "Enable sops secrets";
            };
          };
        }
        inputs.sops-nix.nixosModules.sops
      ]
      ++ (lib.optional (inputs ? nixos-credentials) "${inputs.nixos-credentials}/secrets.nix");

      config = lib.mkIf cfg.enable {
        # Sops config
        sops = {
          defaultSopsFile = ./secrets/master.yaml;
          defaultSopsFormat = "yaml";
          age.keyFile = "${config.hm.home.homeDirectory}/.config/sops/age/keys.txt";
        };
      };
    };
}
