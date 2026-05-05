{pkgs, ...}: {
  plugins.telescope = {
    enable = true;

    extensions.fzf-native.enable = true;

    keymaps = {
      "<leader>ff" = {
        action = "find_files";
        options = {desc = "Telescope find file";};
      };
      "<leader>fg" = {
        action = "live_grep";
        options = {desc = "Telescope live grep";};
      };
      "<leader>fb" = {
        action = "buffers";
        options = {desc = "Telescope buffers";};
      };
      "<leader>fh" = {
        action = "help_tags";
        options = {desc = "Telescope help tags";};
      };
    };
  };

  extraPackages = [
    pkgs.ripgrep # required for explorer search
  ];
}
