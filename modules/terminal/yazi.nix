{lib, ...}: {
  flake.modules.nixos.terminal = {pkgs, ...}: {
    hm = {
      programs.yazi = {
        enable = true;
        shellWrapperName = "Y";

        plugins = {
          inherit (pkgs.yaziPlugins) piper;
        };

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
          preview = {
            max_width = 20050;
          };

          plugin.prepend_previewers = let
            bat = "${lib.getExe pkgs.bat} -p --color=always";
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

        initLua =
          # lua
          ''
            function Linemode:size_and_mtime()
              local time = math.floor(self._file.cha.mtime or 0)
              if time == 0 then
                time = ""
              elseif os.date("%Y", time) == os.date("%Y") then
                time = os.date("%b %d %H:%M", time)
              else
                time = os.date("%b %d  %Y", time)
              end

              local size = self._file:size()
              return string.format("%s %s", size and ya.readable_size(size) or "-", time)
            end
          '';
      };
    };
  };
}
