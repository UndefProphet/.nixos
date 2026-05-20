{inputs, lib, ...}: {


  # flake-file.inputs.fuzzy-search-yazi = {
  #   url = "github:onelocked/fuzzy-search.yazi";
  #   inputs.nixpkgs.follows = "nixpkgs";
  # };

  flake.modules.nixos.terminal = {pkgs, ...}: {
    hm = {
      # imports = [ inputs.fuzzy-search-yazi.homeManagerModules.default ];
      programs.yazi = {
        enable = true;
        shellWrapperName = "Y";

        plugins = {
          inherit (pkgs.yaziPlugins) piper;
          inherit (pkgs.yaziPlugins) toggle-pane;

        };

        # yaziPlugins.plugins = {
        #   fuzzy-search = {
        #     enable = true; # enables the plugin
        #     enableFishIntegration = true;  # Enables the Fish function for Zoxide Shift + Z
        #     depth = 3; # eza tree depth control default is =TL=3
        #     keymaps = {  # sets default keybinds see below
        #       fd = true;
        #       rg = true;
        #       zoxide = true;
        #     };
        #   };
        # };

        extraPackages = with pkgs; [
          starship
          git
          lazygit
        ];

        settings = {
          mgr = {
            ratio = [
              2
              3
              5
            ];
            sort_dir_first = true;
            linemode = "size_and_mtime";
          };

          plugin.prepend_previewers = let
            bat = "${lib.getExe pkgs.bat} -p --color=always --theme base16";
            qemu-img = lib.getExe' pkgs.qemu-utils "qemu-img";
          in
            with pkgs; [
              {
                url = "*.md";
                run = ''piper -- CLICOLOR_FORCE=1 ${lib.getExe glow} -w=$w -s=dark -- "$1"'';
              }
              {
                mime = "text/*";
                run = ''piper -- ${bat} "$1"'';
              }
              {
                mime = "*/{xml,javascript,x-wine-extension-ini}";
                run = ''piper -- ${bat} "$1"'';
              }
              {
                url = "*.qcow2";
                run = ''piper -- ${qemu-img} info "$1" | ${bat} -l asa'';
              }
              {
                url = "*/";
                run = ''piper -- ${lib.getExe eza} --color=always --icons=always --no-quotes -TL=3 "$1"'';
              }
              {
                url = "*.txt.gz";
                run = ''piper -- ${lib.getExe gzip} -dc "$1"'';
              }
              {
                mime = "application/{*zip,tar,bzip2,7z*,rar,xz,zstd,java-archive}";
                run = "ouch --show-file-icons";
              }
            ];

          plugin.append_previewers = [
            {
              url = "*";
              run = ''piper -- ${lib.getExe pkgs.hexyl} --border=none --terminal-width=$w "$1"'';
            }
          ];
        };

        theme = {
          indicator = {
            padding = {
              open = "▐";
              close = "▌";
            };
          };

          status = {
            sep_right = {
              open = "▐";
              close = "";
            };
            sep_left = {
              open = "";
              close = "▌";
            };
          };
        };

        # initLua =
        #   # lua
        #   ''
        #     function Linemode:size_and_mtime()
        #       local time = math.floor(self._file.cha.mtime or 0)
        #       if time == 0 then
        #         time = ""
        #       elseif os.date("%Y", time) == os.date("%Y") then
        #         time = os.date("%b %d %H:%M", time)
        #       else
        #         time = os.date("%b %d  %Y", time)
        #       end
        #
        #       local size = self._file:size()
        #       return string.format("%s %s", size and ya.readable_size(size) or "-", time)
        #     end
        #     '';
        #
        keymap = {
          mgr.prepend_keymap = [
            {
              on = ["T"];
              run  = "plugin toggle-pane min-parent";
              desc = "Show or hide ...";
            }
          ];
        };
        # keymap = {
        #   mgr.prepend_keymap = [
        #     {
        #       on = [ "z" ];
        #       run = "plugin fuzzy-search -- fd --TL=3";
        #       desc = "Fuzzy Find Files";
        #     }
        #     {
        #       on = [ "<S-s>" ];
        #       run = "plugin fuzzy-search -- rg --TL=3";
        #       desc = "Ripgrep Search";
        #     }
        #     {
        #       on = [ "<S-z>" ];
        #       run = "plugin fuzzy-search -- zoxide --TL=3";
        #       desc = "Zoxide Search";
        #     }
        #   ];
        # };

      };
    };
  };
}
