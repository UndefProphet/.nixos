{
  flake.modules.nixos.git = {
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
