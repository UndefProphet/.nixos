{
  flake.modules.nixos.opencode = { lib, ... }: {
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
}
