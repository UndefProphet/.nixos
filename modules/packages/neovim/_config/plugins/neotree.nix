{lib, ...}: {
  plugins.neo-tree = {
    enable = true;
    settings = {
      sources = ["filesystem" "buffers" "git_status"];
      # source_selector = {
      #   winbar = true;
      #   lualine = false;
      # };
      openFilesDoNotReplaceTypes = ["terminal" "Trouble" "trouble" "qf" "Outline"];

      close_if_last_window = true;
      filesystem = {
        use_libuv_file_watcher = true;
        follow_current_file = {
          enabled = true;
          leave_dirs_open = true;
        };
        filtered_items = {
          visible = true;
          hide_dotfiles = false;
          hide_gitignored = false;
        };
      };

      window = {
        position = "left";
        width = 30;

        mappings = {
          "l" = "open";
          "h" = "close_node";
          "<space>" = "none";
          "P" = lib.nixvim.utils.listToUnkeyedAttrs ["toggle_preview"] // {config = {use_float = false;};};
          "y" =
            lib.nixvim.utils.listToUnkeyedAttrs [
              {
                __raw = ''
                  function(state)
                      local node = state.tree:get_node()
                      local path = node:get_id()
                      vim.print("Yanked:".. path)
                      vim.fn.setreg("+", path, "c")
                  end
                '';
              }
            ]
            // {desc = "Copy Path to Clipboard";};
          "O" =
            lib.nixvim.utils.listToUnkeyedAttrs [
              {
                __raw = ''
                  function(state)
                    require("lazy.util").open(state.tree:get_node().path, { system = true })
                  end
                '';
              }
            ]
            // {desc = "Open with System Application";};
        };
      };

      defaultComponentConfigs = {
        indent = {
          withExpanders = true;
          expanderCollapsed = "";
          expanderExpanded = "";
          expanderHighlight = "NeoTreeExpander";
        };
        gitStatus = {
          symbols = {
            unstaged = "󰄱";
            staged = "󰱒";
          };
        };
      };
    };
  };

  autoCmd = [
    {
      event = "TermClose";
      pattern = "*lazygit*";
      callback = {
        __raw = ''
          function()
            if package.loaded["neo-tree.sources.git_status"] then
              require("neo-tree.sources.git_status").refresh()
            end
          end
        '';
      };
    }
  ];
}
