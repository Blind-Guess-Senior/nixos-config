{
  config,
  pkgs,
  ...
}:
{
  programs.firefox = {
    enable = true;

    languagePacks = [
      "en-US"
      "zh-CN"
    ];

    nativeMessagingHosts = [ pkgs.kdePackages.plasma-browser-integration ];

    policies = {
      AppAutoUpdate = false;
      BackgroundAppUpdate = false;

      DefaultDownloadDirectory = "${config.home.homeDirectory}/Downloads";

      DontCheckDefaultBrowser = true;

      DisableAccounts = true;
      DisableFirefoxAccounts = true;
      DisableFirefoxScreenshots = true;

      DisplayBookmarksToolbar = "always"; # alternatives: "always", "never" or "newtab"
      DisplayMenuBar = "always"; # alternatives: "always", "never" or "default-on" "default-off"

      DisableMasterPasswordCreation = true;

      SearchBar = "unified"; # alternative: "separate"

      ExtensionSettings = {
        "*".installation_mode = "blocked"; # blocks all addons except the ones specified below
        # uBlock Origin:
        "uBlock0@raymondhill.net" = {
          installation_mode = "force_installed";
          private_browsing = true;
        };
        # Bitwarden
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          installation_mode = "force_installed";
          private_browsing = true;
        };
        # Plasma Desktop Integration
        "plasma-browser-integration@kde.org" = {
          installation_mode = "force_installed";
          private_browsing = true;
        };
      };
    };

    profiles = {
      "default" = {
        id = 0;
        path = config.home.username;

        settings = {
          "app.normandy.first_run" = true;
          "browser.aboutwelcome.enabled" = true;

          "browser.ai.control.sidebarChatbot" = {
            Value = "blocked";
            Status = "locked";
          };

          "browser.bookmarks.addedImportButton" = false;

          "browser.download.alwaysOpenPanel" = true;
          "browser.download.autohideButton" = false;

          "browser.link.open_newwindow" = {
            Value = 3;
            Status = "locked";
          };

          "browser.ml.chat.enabled" = false;
          "browser.ml.chat.page" = false;

          "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
          "browser.newtabpage.activity-stream.feeds.snippets" = false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
          "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = false;
          "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = false;
          "browser.newtabpage.activity-stream.section.highlights.includeVisited" = false;

          "browser.tabs.tabmanager.enabled" = false;

          "browser.urlbar.trustPanel.breachAlerts" = false;

          "datareporting.usage.uploadEnabled" = false;

          "intl.accept_languages" = "en-us,en,zh-cn,zh";

          "privacy.globalprivacycontrol.enabled" = true;

          "sidebar.verticalTabs" = true;
          "sidebar.verticalTabs.dragToPinPromo.dismissed" = true;

          "signon.firefoxRelay.feature" = {
            Value = "disabled";
            Status = "locked";
          };
          "signon.management.page.breach-alerts.enabled" = false;
        };

        search = {
          default = "ddg";
          privateDefault = "ddg";

          # force = true;

          engines = {
            nix-packages = {
              name = "Nix Packages";
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
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
              definedAliases = [
                "@np"
                "@nixpkg"
              ];
            };

            nix-package-options = {
              name = "Nix Package Options";
              urls = [
                {
                  template = "https://search.nixos.org/options";
                  params = [
                    {
                      name = "type";
                      value = "options";
                    }
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
              definedAliases = [
                "@no"
                "@nixopt"
              ];
            };

            nixos-wiki = {
              name = "NixOS Wiki";
              urls = [ { template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; } ];
              iconMapObj."16" = "https://wiki.nixos.org/favicon.ico";
              definedAliases = [ "@nw" ];
            };

            # bing.metaData.hidden = true;
            google.metaData.alias = "@g"; # builtin engines only support specifying one additional alias
          };

          order = [
            "ddg"
            "bing"
            "google"
          ];
        };

        bookmarks = {
          force = true;
          settings = [
            {
              name = "Nix-Managed Bookmarks";
              toolbar = true;
              bookmarks = [
                {
                  name = "坛 博";
                  bookmarks = [
                    {
                      name = "论坛";
                      bookmarks = [ ];
                    }

                  ];
                }
                {
                  name = "Computer";
                  bookmarks = [
                    {
                      name = "Linux";
                      bookmarks = [
                        {
                          name = "Nix & NixOS";
                          bookmarks = [
                            {
                              name = "Nix Cookbook - Official NixOS Wiki";
                              tags = [
                                "NixOS"
                              ];
                              keyword = "cookbook";
                              url = "https://wiki.nixos.org/wiki/Nix_Cookbook";
                            }
                            {
                              name = "Noogle";
                              tags = [
                                "NixOS"
                                "Utils"
                              ];
                              keyword = "noogle";
                              url = "https://noogle.dev";
                            }
                          ];
                        }
                      ];
                    }
                  ];
                }
                "separator"
                {
                  name = "其他";
                  bookmarks = [
                    {
                      name = "Terraria 中文 Wiki";
                      tags = [
                        "wiki"
                        "game"
                      ];
                      keyword = "terriaria";
                      url = "https://terraria.wiki.gg/zh/wiki/Terraria_Wiki";
                    }
                  ];
                }
              ];
            }
          ];
        };
      };
    };
  };
}
