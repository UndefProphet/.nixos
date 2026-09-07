{
  flake.modules.nixos.opencode =
    { config, lib, ... }:
    let
      cfg = config.conf.packages.opencode;
    in
    {
      imports = [
        {
          options.conf.packages.opencode = {
            enable = lib.mkEnableOption {
              default = false;
              description = "Enable opencode";
            };
          };
        }
      ];

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
