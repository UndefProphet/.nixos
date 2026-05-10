{
  inputs,
  lib,
  ...
}: {
  # https://github.com/nix-community/disko
  # Disc partitioning and declaration
  flake-file.inputs.disko = {
    type = "github";
    owner = "nix-community";
    repo = "disko";
    ref = "master";
  };

  imports = [
    inputs.disko.flakeModules.default
  ];

  flake.diskoConfigurations.default = args @ {
    os,
    home ? null,
    swapSize,
    ...
  }: {
    imports = [inputs.disko.nixosModules.disko];
    disko.devices = {
      disk =
        {
          main = {
            type = "disk";
            device = os;
            content = {
              type = "gpt";
              partitions = {
                ESP = {
                  priority = 1;
                  name = "ESP";
                  start = "1M";
                  end = "1G";
                  type = "EF00";
                  content = {
                    type = "filesystem";
                    format = "vfat";
                    mountpoint = "/boot";
                    mountOptions = ["umask=0077"];
                  };
                };

                root = {
                  size = "100%";
                  content = {
                    type = "btrfs";
                    extraArgs = ["-f"]; # Override existing partition
                    subvolumes =
                      {
                        "@rootfs" = {
                          mountpoint = "/";
                        };
                        "@nix" = {
                          mountOptions = [
                            "compress=zstd"
                            "noatime"
                          ];
                          mountpoint = "/nix";
                        };
                        "@swap" = {
                          mountpoint = "/.swapvol";
                          swap = {
                            swapfile.size = swapSize;
                          };
                        };
                      }
                      // lib.optionalAttrs (args.home == null) {
                        "@home" = {
                          mountOptions = ["compress=zstd"];
                          mountpoint = "/home";
                        };
                      };
                  };
                };
              };
            };
          };
        }
        // lib.optionalAttrs (args.home != null) {
          home = {
            type = "disk";
            device = args.home;
            content = {
              type = "gpt";
              partitions = {
                home = {
                  size = "100%";
                  content = {
                    type = "btrfs";
                    extraArgs = ["-f"]; # Override existing partition
                    subvolumes = {
                      "@home" = {
                        mountOptions = ["compress=zstd"];
                        mountpoint = "/home";
                      };
                    };
                  };
                };
              };
            };
          };
        };
    };
  };
}
