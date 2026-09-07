{ self, lib, ... }: {
  ### --- Basic Utilities ---
  flake.modules.nixos.packages-generic =
    {
      config,
      lib,
      pkgs,
      username,
      ...
    }:
    let
      cfg = config.conf.packages.packages-generic;
    in
    {
      imports = [
        {
          options.conf.packages.packages-generic = {
            enable = lib.mkEnableOption {
              default = false;
              description = "Enable generic packages";
            };
          };
        }
      ]
      ++ (with self.modules.nixos; [
        spotify
        thunderbird
        neomutt
        firefox
        opencode
        zathura
        discord
        ddcutil
      ]);

      config = lib.mkIf cfg.enable {
        users.users."${username}".packages = with pkgs; [
          killall # Kill processes by name
          wget # Download files over HTTP/FTP
          libnotify # Notification library
          pciutils # PCI device tools (`lspci`)
          usbutils # USB device tools (`lsusb`)
          wakeonlan # Send WoL packets
          dmidecode # Hardware information (DMI/SMBIOS)
          memtester # Memory testing utility

          vlc # Video player
          deluge # Torrent client
          feh # Image viewer
          keepassxc # Password manager

          ### --- File Management ---
          nemo # File manager (Cinnamon)
          file-roller # Archive manager
          gnome-disk-utility # Required for disk management + Nemo integration

          ### --- Temporary ---
          networkmanagerapplet
          blueman
          pasystray

          ouch-rar # TODO: move this to yazi or terminal
        ];
      };
    };

  ### --- Wayland Utilities ---
  flake.modules.nixos.packages-wayland =
    {
      config,
      lib,
      pkgs,
      username,
      ...
    }:
    let
      cfg = config.conf.packages.packages-wayland;
    in
    {
      imports = [
        {
          options.conf.packages.packages-wayland = {
            enable = lib.mkEnableOption {
              default = false;
              description = "Enable wayland utilities";
            };
          };
        }
      ];

      config = lib.mkIf cfg.enable {
        users.users."${username}".packages = with pkgs; [
          wdisplays # GUI display configuration tool
        ];
      };
    };

  ### --- Nix Utilities ---
  flake.modules.nixos.packages-nix-utilities =
    {
      config,
      lib,
      pkgs,
      username,
      ...
    }:
    let
      cfg = config.conf.packages.packages-nix-utilities;
    in
    {
      imports = [
        {
          options.conf.packages.packages-nix-utilities = {
            enable = lib.mkEnableOption {
              default = false;
              description = "Enable nix utilities";
            };
          };
        }
      ]
      ++ (with self.modules.nixos; [
        comma
      ]);

      config = lib.mkIf cfg.enable {
        users.users."${username}".packages = with pkgs; [
          nix-output-monitor # Real-time logging for nix builds
          expect # Automate interactive CLI programs
          nurl # Fetch GitHub metadata for Nix packaging
        ];
      };
    };

  flake.modules.nixos.packages-creative =
    {
      config,
      lib,
      pkgs,
      username,
      ...
    }:
    let
      cfg = config.conf.packages.packages-creative;
    in
    {
      imports = [
        {
          options.conf.packages.packages-creative = {
            enable = lib.mkEnableOption {
              default = false;
              description = "Enable creative packages";
            };
          };
        }
      ]
      ++ (with self.modules.nixos; [
        obs
        yt-dlp
      ]);

      config = lib.mkIf cfg.enable {
        users.users."${username}".packages = with pkgs; [
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
        ];
      };
    };

}
