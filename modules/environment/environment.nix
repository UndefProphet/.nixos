{
  flake.modules.nixos.environment = {
    qt = {
      enable = true;
      # platformTheme = "qt5ct";
      # style = "kvantum";
    };

    security.polkit = {
      enable = true;
    };

    # TODO: remove these and add them to the keymaps for each WNM or keybinding software
    hm = {
    };
  };
}
