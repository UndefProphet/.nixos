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

  colorschemes.gruvbox = {
    enable = lib.mkDefault true;
    settings = {
      terminal_colors = lib.mkDefault true; # add neovim terminal colors
      undercurl = lib.mkDefault true;
      underline = lib.mkDefault true;
      bold = lib.mkDefault true;
      italic = {
        strings = lib.mkDefault true;
        emphasis = lib.mkDefault true;
        comments = lib.mkDefault true;
        operators = lib.mkDefault false;
        folds = lib.mkDefault true;
      };
      strikethrough = lib.mkDefault true;
      invert_selection = lib.mkDefault false;
      invert_signs = lib.mkDefault false;
      invert_tabline = lib.mkDefault false;
      inverse = lib.mkDefault true; # invert background for search, diffs, statuslines and errors
      contrast = lib.mkDefault ""; # can be "hard", "soft" or empty string
      palette_overrides = {};
      overrides = {};
      dim_inactive = lib.mkDefault false;
      transparent_mode = lib.mkDefault true;
    };
  };
}
