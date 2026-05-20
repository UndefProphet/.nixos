{
  flake.modules.nixos.terminal = {
    lib,
    pkgs,
    username,
    configdir,
    config,
    configurationName,
    ...
  }: {
    # User shell
    users.users."${username}".shell = pkgs.fish;
    programs.fish.enable = true;

    hm = {...}: {
      programs.foot = {
        enable = true;
        server.enable = true;
        settings = {
          main = {
            pad = "10x10";
          };
        };
      };

      programs.fish = {
        enable = config.programs.fish.enable;
        # shellInit = ''
        # tmux
        # '';
        functions = {
          fish_greeting = "";
        };
      };

      programs.nix-your-shell.enable = true;
      programs.zoxide.enable = true;
      programs.starship.enable = true;
      programs.lsd.enable = true;
      programs.btop.enable = true;

        programs.direnv = {
          enable = true;
          nix-direnv.enable = true;
        };

      home.packages = [
        pkgs.isd
      ];

      programs.nh = {
        enable = true;
        flake = "${configdir}#${configurationName}";
      };

      home.shellAliases = let
        configName = "desktop";

        # Nix management
        update-normal = "nice -n 19 sudo nix flake update --flake ${configdir}";
        rebuild-normal = "nice -n 19 sudo nixos-rebuild switch --flake ${configdir}#${configName}";
        rebuild-test-normal = "nice -n 19 sudo nixos-rebuild test --flake ${configdir}#${configName}";

        update = "nice -n 19 sudo nix flake update ${configdir}";
        rebuild = "nice -n 19 nh os switch --diff always ${configdir} --hostname ${configName}";
        rebuild-test = "nice -n 19 nh os test --diff always ${configdir} --hostname ${configName}";
        rebuild-boot = "nice -n 19 nh os boot --diff always ${configdir} --hostname ${configName}";
        rebuild-build = "nice -n 19 nh os build --diff always ${configdir} --hostname ${configName}";
        rebuild-vm = "nice -n 19 nh os build-vm --diff always ${configdir} --hostname ${configName}";

        # FANCY shit
        system = "fastfetch";
        # system-clean = "${clear} && ${system}";

        # AUDIO
        audiocarla = "PIPEWIRE_LATENCY=1024/48000 carla --cnprefix Microphone ~/.config/audio/carla/rack.carxp";
        # audiojacktrip =
        #   "while true; do PIPEWIRE_LATENCY=1024/48000 jacktrip -s -q auto -B 4465 -D --udprt; sleep 1; done";
        # audio =
        #   "${audiocarla} & ${audiojacktrip} &"; # Run both carla and jacktrip
        restart-audio = "systemctl --user restart pipewire{,-pulse}.socket audio-auto-start.service";
      in {
        # Vim to NVim
        v = "nvim";
        vi = "nvim";
        vim = "nvim";

        # Utilities
        disks = lib.getExe pkgs.disktui;
        browse = lib.getExe pkgs.yazi;

        your = "test";

        # Improvements
        # ls = "lsd -lhFXN";
        open = "xdg-open";
        cat = "${pkgs.bat}/bin/bat";
        # top = "${pkgs.btop}/bin/btop";
        cd = "z"; # Zoxide alias

        # Nix management
        rebuild-test-normal = rebuild-test-normal;
        update-normal = update-normal;
        rebuild-normal = rebuild-normal;

        update = update;
        rebuild = rebuild;
        rebuild-test = rebuild-test;
        rebuild-boot = rebuild-boot;
        rebuild-build = rebuild-build;
        rebuild-vm = rebuild-vm;

        # FANCY shit
        system = system;
        # system-clean = "${system-clean}";

        # AUDIO
        audiocarla = audiocarla;
        # audiojacktrip = "${audiojacktrip}";
        # audio = "${audio}";
        restart-audio = restart-audio;

        k8 = "kubectl --kubeconfig ~/.kube/k3s-prod1.yaml";
        k8prd = "kubectl --kubeconfig ~/.kube/k3s-prod1.yaml";
      };
    };
  };
}
