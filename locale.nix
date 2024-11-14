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
        "MiSans"
        "LXGW WenKai Mono"
        "Noto Sans CJK SC"
        "Sarasa Mono SC"
      ];
      defaultFonts.sansSerif = [
        "MiSans"
        "LXGW WenKai Mono"
        "Noto Sans CJK SC"
        "DejaVu Sans"
      ];
      defaultFonts.serif = [
        "LXGW WenKai Mono"
        "MiSans"
        "Noto Sans CJK SC"
      ];

      localConf = ''
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
        <fontconfig>
          <!-- Set MiSans as default for system-ui -->
          <match target="pattern">
            <test qual="any" name="family">
                <string>system-ui</string>
            </test>
            <edit name="family" mode="prepend" binding="strong">
                <string>MiSans</string>
            </edit>
          </match>

          <!-- Set MiSans as default for -apple-system -->
          <match target="pattern">
            <test qual="any" name="family">
                <string>-apple-system</string>
            </test>
            <edit name="family" mode="prepend" binding="strong">
                <string>MiSans</string>
            </edit>
          </match>
          <!-- Use language-specific font variants. -->
          ${
            lib.concatMapStringsSep "\n"
              (
                { lang, variant }:
                let
                  replace = from: to: ''
                    <match target="pattern">
                      <test name="lang">
                        <string>${lang}</string>
                      </test>
                      <test name="family">
                        <string>${from}</string>
                      </test>
                      <edit name="family" binding="strong">
                        <string>${to}</string>
                      </edit>
                    </match>
                  '';
                in
                replace "Noto Sans CJK SC" "Noto Sans CJK ${variant}"
                + replace "Noto Serif CJK SC" "Noto Serif CJK ${variant}"
              )
              [
                {
                  lang = "zh-TW";
                  variant = "TC";
                }
                {
                  lang = "zh-HK";
                  variant = "HK";
                }
                {
                  lang = "ja";
                  variant = "JP";
                }
                {
                  lang = "ko";
                  variant = "KR";
                }
              ]
          }
        </fontconfig>
      '';
    };

    packages =
      (with pkgs; [
        # symbola # 特殊字符
        jetbrains-mono
        font-awesome

        noto-fonts-color-emoji
        twitter-color-emoji
        unicode-emoji

        cascadia-code
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        # sarasa-gothic
        noto-fonts
        wqy_microhei
        wqy_zenhei
        lxgw-wenkai
        intel-one-mono
      ])
      ++ [
        # pkgs.nerdfonts
        nerdfonts
      ];
  };
}
