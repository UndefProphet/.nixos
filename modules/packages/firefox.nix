{inputs, ...}: {
  flake-file.inputs.glide-browser = {
    url = "github:glide-browser/glide.nix";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.home-manager.follows = "home-manager";
  };

  flake.modules.nixos.firefox = {
    pkgs,
    lib,
    ...
    }: {
      # Home manager
      hm = {config, ...}: {
        imports = [inputs.glide-browser.homeModules.default];

        programs.glide-browser = {
          enable = true;
          nativeMessagingHosts = [pkgs.keepassxc];

          profiles = let
            defaults = {
              settings = {
                # Features
                "image.jxl.enabled" = true;

                # Themeing
                "toolkit.legacyUserProfileCustomizations.stylesheets" = true; # Enable userChrome.
                "browser.aboutConfig.showWarning" = true; # Disable about:config warning.
                "browser.startup.page" = 3; # restore session on startup
                "layout.css.heading-selector.enabled" = true;
                "layout.css.has-selector.enabled" = true;
                "browser.tabs.allow_transparent_browser" = true; # Enable transperancy in the browser window.

                # Sidebar
                "sidebar.verticalTabs" = true; # Vertical tabs.
                # "sidebar.visibility" = "expand-on-hover"; # Expand on hover.
                "sidebar.expandOnHover" = true; # Expand on hover.
                "sidebar.animation.enabled" = false; # Make everything instant.
                "sidebar.main.tools" = "aichat,syncedtabs,history,bookmarks"; # Sidebar utilities at the bottom.
              };

              # userChrome = ''
              #   :root {
              #     --tabpanel-background-color: transparent !important; /* browser background */
              #
              #     --toolbox-bgcolor: #1d2021d9 !important;
              #     --toolbox-bgcolor-inactive: #1d2021d9 !important;
              #   }
              # '';

              extensions = {
                force = true;
                packages = with pkgs.nur.repos.rycee.firefox-addons; [
                  ublock-origin
                ];
                settings = {
                };
              };

              search.force = true;
              search.engines = {
                # Nix packages
                nix-packages = {
                  name = "Nix Packages";
                  urls = [
                    {
                      template = "https://search.nixos.org/packages";
                      params = [
                        {
                          name = "channel";
                          value = "unstable";
                        }
                        {
                          name = "query";
                          value = "{searchTerms}";
                        }
                      ];
                    }
                  ];
                  icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                  definedAliases = ["nixp"];
                };

                # Nix options
                nix-options = {
                  name = "Nix Options";
                  urls = [
                    {
                      template = "https://search.nixos.org/options";
                      params = [
                        {
                          name = "channel";
                          value = "unstable";
                        }
                        {
                          name = "query";
                          value = "{searchTerms}";
                        }
                      ];
                    }
                  ];
                  icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                  definedAliases = ["nixo"];
                };

                # Home manager options
                home-options = {
                  name = "Nix Home Manager";
                  urls = [
                    {
                      template = "https://home-manager-options.extranix.com";
                      params = [
                        {
                          name = "release";
                          value = "master";
                        }
                        {
                          name = "query";
                          value = "{searchTerms}";
                        }
                      ];
                    }
                  ];
                  icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                  definedAliases = ["hm"];
                };
              };
            };

          in {
            default = defaults // {
              name = "default";
              isDefault = true;
              id = 0;
            };
            streaming = defaults // {
              name = "streaming";
              isDefault = false;
              id = 1;
            };
          };
        };

      xdg.mimeApps = let
        browser = ["glide-browser.desktop"];
      in
        lib.mkIf config.programs.glide-browser.enable {
          defaultApplications = {
            "x-scheme-handler/http" = browser;
            "x-scheme-handler/https" = browser;
            "x-scheme-handler/chrome" = browser;
            "text/html" = browser;
            "application/x-extension-htm" = browser;
            "application/x-extension-html" = browser;
            "application/x-extension-shtml" = browser;
            "application/xhtml+xml" = browser;
            "application/x-extension-xhtml" = browser;
            "application/x-extension-xht" = browser;
          };

          associations.added = {
            "x-scheme-handler/http" = browser;
            "x-scheme-handler/https" = browser;
            "x-scheme-handler/chrome" = browser;
            "text/html" = browser;
            "application/x-extension-htm" = browser;
            "application/x-extension-html" = browser;
            "application/x-extension-shtml" = browser;
            "application/xhtml+xml" = browser;
            "application/x-extension-xhtml" = browser;
            "application/x-extension-xht" = browser;
          };
        };

      # Firefox Incognito
      xdg.desktopEntries = {
        firefox-incognito = {
          name = "Firefox Incognito";
          genericName = "Web Browser";
          icon = "firefox";
          exec = "firefox --private-window";
          terminal = false;

          categories = [
            "Application"
            "Network"
            "WebBrowser"
          ];

          mimeType = [
            "text/html"
            "text/xml"
          ];
        };
      };
    };
  };
}
