{ lib, ... }: {
  plugins = {
    mini-ai = {
      enable = true;
      settings = {
        n_lines = 50;
        search_method = "cover_or_next";
      };
    };

    mini-diff = {
      enable = true;
      settings = {
        view = {
          style = "sign";
        };
      };
    };

    mini-comment = {
      enable = true;
      settings = {
        mappings = {
          comment = "<leader>/";
          comment_line = "<leader>/";
          comment_visual = "<leader>/";
          textobject = "<leader>/";
        };
      };
    };

    mini-surround = {
      enable = true;
      settings = {
        mappings = {
          add = "gsa";
          delete = "gsd";
          find = "gsf";
          find_left = "gsF";
          highlight = "gsh";
          replace = "gsr";
          update_n_lines = "gsn";
        };
      };
    };

    mini-starter = {
      enable = true;
      settings = {
        content_hooks = {
          "__unkeyed-1.adding_bullet" = {
            __raw = "require('mini.starter').gen_hook.adding_bullet()";
          };
          "__unkeyed-2.indexing" = {
            __raw = "require('mini.starter').gen_hook.indexing('all', { 'Builtin actions' })";
          };
          "__unkeyed-3.padding" = {
            __raw = "require('mini.starter').gen_hook.aligning('center', 'center')";
          };
        };
        evaluate_single = true;
        header = ''
          ███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗
          ████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║
          ██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║
          ██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║
          ██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║
        '';
        items = {
          "__unkeyed-1.buildtin_actions" = {
            __raw = "require('mini.starter').sections.builtin_actions()";
          };
          "__unkeyed-2.recent_files_current_directory" = {
            __raw = "require('mini.starter').sections.recent_files(10, false)";
          };
          "__unkeyed-3.recent_files" = {
            __raw = "require('mini.starter').sections.recent_files(10, true)";
          };
          "__unkeyed-4.sessions" = {
            __raw = "require('mini.starter').sections.sessions(5, true)";
          };
        };
      };
    };

    mini-sessions = {
      enable = true;
      settings = {
        autoread = false;
        autowrite = true;
        file = "Session.vim";
        force = {
          delete = false;
          read = false;
          write = true;
        };
        hooks = {
          post = {
            delete = lib.nixvim.mkRaw "nil";
            read = lib.nixvim.mkRaw "nil";
            write = lib.nixvim.mkRaw "nil";
          };
          pre = {
            delete = lib.nixvim.mkRaw "nil";
            read = lib.nixvim.mkRaw "nil";
            write = lib.nixvim.mkRaw "nil";
          };
        };
        verbose = {
          delete = true;
          read = false;
          write = true;
        };
      };
    };
  };
}
