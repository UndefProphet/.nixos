{
  lib,
  modulesPath,
  config,
  pkgs,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];
  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "thunderbolt"
    "sdhci_pci"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.enableRedistributableFirmware = true;
  boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Amd cpu support for different programs like btop
  nixpkgs.config.rocmSupport = true;

  boot.kernelParams = [
    # Fix for getting stuck during boot
    "amdgpu.dcdebugmask=0x400"

    # Hardware
    "amdgpu.gpu_recovery=1" # Enables automatic recovery if the GPU hangs
    "amdgpu.gfx_off=0" # Disables GFXoff if experiencing power-state instability
    "iommu=pt" # Improves IOMMU passthrough performance
  ];

  boot.extraModprobeConfig = ''
    options asus_nb_wmi wapf=4
  '';

  services.scx = {
    enable = true;
    scheduler = "scx_p2dq";
  };

  # Battery
  # services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  services.displayManager.ly = {
    settings = {
      battery_id = "BAT0";
    };
  };

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "balancepower";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_power";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 95;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;

      # Optional helps save long term battery health
      # START_CHARGE_THRESH_BAT0 = 40;
      # STOP_CHARGE_THRESH_BAT0 = 90;
    };
  };

  hm.services.wluma = {
    enable = true;
    settings = {

      als.iio = {
        path = "/sys/bus/iio/devices";
        thresholds = {
          "0" = "night";
          "15" = "dark";
          "50" = "dim";
          "150" = "normal";
          "300" = "bright";
          "450" = "outdoors";
        };
      };

      output.backlight = [
        {
          name = "eDP-1";
          path = "/sys/class/backlight/amdgpu_bl1";
          capturer = "none";
        }
      ];

      keyboard = [
        {
          name = "keyboard-asus";
          path = "/sys/class/leds/asus::kbd_backlight";
        }
      ];
    };
  };
}
