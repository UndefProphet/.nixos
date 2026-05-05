{
  flake.modules.nixos.thunderbird.hm.programs.thunderbird = {
    enable = true;
    profiles.default = {
      isDefault = true;
    };
  };
}
