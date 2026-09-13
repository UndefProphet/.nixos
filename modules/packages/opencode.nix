{ lib, ... }: {
  flake.modules.nixos.opencode =
    { config, ... }:
    let
      cfg = config.conf.packages.opencode;
    in
    {
      options.conf.packages.opencode.enable = lib.mkEnableOption {
        description = "Enable opencode";
      };

      config = lib.mkIf cfg.enable {
        hm.programs.opencode = {
          enable = true;
          tui.theme = lib.mkForce "system";
          enableMcpIntegration = true;
          settings = {
            mcp = {
              context7 = {
                enabled = true;
                type = "remote";
                url = "https://mcp.context7.com/mcp";
                headers = {
                  "CONTEXT7_API_KEY" = "YOUR_API_KEY";
                };
              };
            };
          };
        };
      };
    };
}
