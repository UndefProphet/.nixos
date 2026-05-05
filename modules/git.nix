{
  flake.modules.nixos.git = {
    # Home manager
    hm = {
      programs.git = {
        enable = true;
      };

      services.ssh-agent = {
        enable = true;
      };
    };
  };
}
