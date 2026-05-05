{inputs, ...}: {
  flake.modules.nixos.packages = {
    username,
    pkgs,
    ...
  }: {
    users.users."${username}".packages = with pkgs; [
      ### --- Filesystem Tools ---
      ntfs3g # NTFS filesystem support
      exfat # exFAT filesystem support
      nfs-utils # NFS client/server utilities

      impala
      remmina
      xremap

      ### --- Basic Utilities ---
      killall # Kill processes by name
      wget # Download files over HTTP/FTP
      libnotify # Notification library
      pciutils # PCI device tools (`lspci`)
      usbutils # USB device tools (`lsusb`)
      ddcutil # Monitor control (DDC/CI)
      wakeonlan # Send WoL packets
      dmidecode # Hardware information (DMI/SMBIOS)
      memtester # Memory testing utility

      ### --- Video / Media ---
      vlc # Video player
      # mpv

      ### --- Wayland Utilities ---
      wdisplays # GUI display configuration tool

      ### --- Nix Utilities ---
      nix-output-monitor # Real-time logging for nix builds
      expect # Automate interactive CLI programs
      nurl # Fetch GitHub metadata for Nix packaging
    ];

    hm.home.packages = with pkgs; [
      ### --- Core / Shell / System Tools ---
      fastfetch # System info fetch

      ### --- File Management ---
      nemo # File manager (Cinnamon)
      file-roller # Archive manager
      gnome-disk-utility # Required for disk management + Nemo integration

      ouch-rar # TODO: move this to yazi or terminal
      rsync # File sync tool
      nfs-utils # NFS support

      ### --- Torrent Clients ---
      deluge # Torrent client

      ### --- Wallpapers / Background Tools ---
      waypaper
      # mpvpaper
      wallutils
      gowall
      wallust # Colorscheme generator

      ### --- Terminals / TUI ---
      fzf # Fuzzy finder

      ### --- Launchers / Notifications / Utils ---
      libnotify # Notification library

      # TODO: move wayland utilitiesto to ../wm
      ### --- Wayland ---
      kanshi # Dynamic monitor profiles

      ### --- Neovim Helpers ---
      wl-clipboard # Clipboard helper (Wayland)

      ### --- Creative / Production ---
      prismlauncher
      kdePackages.kdenlive # Video editor
      mediainfo # Required by Kdenlive
      audacity # Audio editor
      gimp # Image editor
      libreoffice-qt
      hunspell # Spell checking base
      hunspellDicts.en_GB-large
      hunspellDicts.en_US
      hunspellDicts.sv_SE
      obsidian # Note-taking
      ffmpeg-full # Full FFmpeg build

      ### --- LaTeX ---
      # pandoc # General document converter
      # texlive.combined.scheme-full

      ### --- Temporary / Applets ---
      networkmanagerapplet
      blueman
      pasystray

      keepassxc # Password manager
      feh # Image viewer / wallpaper helper
    ];
  };
}
