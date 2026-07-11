{self, ...}:{
  flake.modules.nixos.common = {
    imports = with self.modules.nixos; [

      # default
      nix
      nur
      grub
      rs-core
      sudo-rs
      audio
      networking
      avahi
      ssh
      secrets

      # NixOS
      stylix
      auto-mount-usb

      # User
      user
      home-manager
      git
      terminal
      environment
      hyprland
      hyprland-tty

      {
        services.tailscale = {
          enable = true;
        };
      }

      gaming

      # Packages
      packages-nix-utilities
      packages-wayland
      packages-generic
      packages-creative
    ];
  };
}
