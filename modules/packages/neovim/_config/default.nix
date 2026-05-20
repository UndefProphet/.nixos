{lib, ...}: {
  # Import all your configuration modules here
  imports = [
    ./options.nix
    ./keymaps.nix
    ./plugins
  ];

  globals.mapleader = lib.mkDefault " "; # Sets the leader key to comma

  plugins.which-key = {
    enable = true;

    luaConfig.pre = lib.mkDefault ''
      vim.o.timeout = true
      vim.o.timeoutlen = 500
    '';
  };

  plugins.web-devicons.enable = lib.mkDefault true;

}
