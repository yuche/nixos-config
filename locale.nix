# for language
#     font config
#     input method
{
  config,
  pkgs,
  lib,
  ...
}:
let
  # nerdfonts package default have too many font zip to download, override for it
  nerdfonts = pkgs.nerdfonts.override {
    fonts = [
      "FiraCode"
      "Hack"
      "UbuntuMono"
      "NerdFontsSymbolsOnly"
    ];
  };

in
# fontconfigFile = import ./fontconfig.nix { inherit config lib pkgs; };
{
  i18n = {
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "zh_CN.UTF-8/UTF-8"
    ];
    inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-rime
        fcitx5-configtool
        fcitx5-chinese-addons
        fcitx5-gtk
        fcitx5-nord
        fcitx5-lua
      ];
    };
  };

  # set nix daemon proxy for user(it's important for chinese users)
  # systemd.services.nix-daemon.environment.http_proxy = "http://localhost:7890";
  # systemd.services.nix-daemon.environment.https_proxy = "http://localhost:7890";
  fonts.fontDir.enable = true;

  system.fsPackages = [ pkgs.bindfs ];
  fileSystems =
    let
      mkRoSymBind = path: {
        device = path;
        fsType = "fuse.bindfs";
        options = [
          "ro"
          "resolve-symlinks"
          "x-gvfs-hide"
        ];
      };
      aggregatedFonts = pkgs.buildEnv {
        name = "system-fonts";
        paths = config.fonts.packages;
        pathsToLink = [ "/share/fonts" ];
      };
    in
    {
      # Create an FHS mount to support flatpak host icons/fonts
      "/usr/share/icons" = mkRoSymBind (config.system.path + "/share/icons");
      "/usr/share/fonts" = mkRoSymBind (aggregatedFonts + "/share/fonts");
    };

  fonts = {
    fontconfig = {
      enable = true;
      hinting = {
        enable = true;
        autohint = false;
        # hintstyle = "hintslight(10px,12px)";
      };
      defaultFonts.emoji = [
        "Twitter Color Emoji"
        "Noto Color Emoji"
      ];
      defaultFonts.monospace = [
        "UbuntuMono Nerd Font Mono"
        "Symbols Nerd Font"
        "Noto Sans Mono CJK SC"
        "LXGW WenKai Mono"
        "Sarasa Mono SC"
      ];
      defaultFonts.sansSerif = [
        "Noto Serif CJK SC"
        "LXGW WenKai Mono"
        "DejaVu Sans"
      ];
      defaultFonts.serif = [
        "Noto Sans CJK SC"
        "LXGW WenKai Mono"
      ];

      localConf = builtins.readFile ./fontconfig/fonts.conf;
    };

    packages =
      (with pkgs; [
        # symbola # 特殊字符
        jetbrains-mono
        font-awesome

        noto-fonts-color-emoji
        twitter-color-emoji

        cascadia-code
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        # sarasa-gothic
        noto-fonts
        lxgw-wenkai
        intel-one-mono
        inter
        sarasa-gothic
      ])
      ++ [
        # pkgs.nerdfonts
        nerdfonts
      ];
  };
}
