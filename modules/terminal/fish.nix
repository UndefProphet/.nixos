{ lib, ... }: {
  flake.modules.nixos.fish =
    {
      config,
      username,
      pkgs,
      ...
    }:
    {

      options.conf.terminal.fish.enable = lib.mkEnableOption { };

      config =
        let
          cfg = config.conf.terminal.fish;
        in
        lib.mkIf cfg.enable {
          users.users."${username}".shell = pkgs.fish;
          programs.fish.enable = true;

          hm = {

            programs.fish = {
              enable = true;
              functions = {
                fish_greeting = "";
              };
            };
          };
        };
    };
}
