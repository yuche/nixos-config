{ pkgs, ... }:
let
  extensions = with pkgs.gnomeExtensions; [
    dash-to-dock
    astra-monitor
    kimpanel
    just-perfection
    appindicator
  ];
in
{
    dconf.settings = {
    # 桌面界面设置
    
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-animations = true;
      # gtk-theme = "Yaru-dark";
      # icon-theme = "Yaru";
    };

    "org/gnome/desktop/wm/preferences" = {
      "num-workspaces" = 1;  # 设置工作区数量为 1
    };

    # 窗口管理器设置
    "org/gnome/mutter" = {
      edge-tiling = false;
    };

    # 电源管理设置
    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-timeout = 3600;
      sleep-inactive-ac-type = "nothing";
    };

    # Shell 扩展设置
    "org/gnome/shell" = {
      enabled-extensions = [
        "just-perfection-desktop@just-perfection"
        "dash-to-dock@micxgx.gmail.com"
        "kimpanel@kde.org"
        "monitor@astraext.github.io"
        "appindicatorsupport@rgcjonas.gmail.com" 
      ];
      # favorite-apps = [
      #   "org.gnome.Nautilus.desktop"
      #   "dev.warp.Warp.desktop"
      #   "org.telegram.desktop.desktop"
      #   "google-chrome.desktop"
      #   "code.desktop"
      #   "mailspring_mailspring.desktop"
      #   "org.gnome.Settings.desktop"
      # ];
    };

    "org/gnome/shell/extensions/just-perfection" = {
      accessibility-menu = true;
      clock-menu-position = 1;
      clock-menu-position-offset = 8;
      dash-icon-size = 0;
      max-displayed-search-results = 0;
      notification-banner-position = 2;
      panel = true;
      panel-in-overview = true;
      ripple-box = true;
      search = true;
      show-apps-button = true;
      startup-status = 1;
      theme = false;
      window-demands-attention-focus = false;
      window-picker-icon = true;
      workspace = true;
      workspaces-in-app-grid = true;
    };

    # Dash to Dock 配置
    "org/gnome/shell/extensions/dash-to-dock" = {
      app-hotkey-4 = ["<Super>c"];
      app-hotkey-5 = ["<Super>s"];
      app-hotkey-6 = ["<Super>e"];
      apply-custom-theme = false;
      background-opacity = 0.8;
      click-action = "minimize";
      custom-theme-shrink = false;
      dash-max-icon-size = 48;
      dock-fixed = false;
      dock-position = "LEFT";
      height-fraction = 0.9;
      hotkeys-overlay = false;
      hotkeys-show-dock = true;
      intellihide-mode = "FOCUS_APPLICATION_WINDOWS";
      middle-click-action = "launch";
      preferred-monitor = -2;
      preferred-monitor-by-connector = "DP-2";
      running-indicator-style = "DOTS";
      shift-click-action = "minimize";
      shift-middle-click-action = "launch";
      show-mounts = false;
    };

    "org/gnome/shell/keybindings" = {
      toggle-quick-settings = [];
    };

    # 键盘快捷键设置
    "org/gnome/desktop/wm/keybindings" = {
      switch-applications = [""];
      activate-window-menu = [];
      switch-applications-backward = [""];
      switch-group = ["<Control>grave"];
      switch-group-backward = ["<Shift><Control>grave"];
      switch-input-source = [""];
      switch-input-source-backward = [""];
      switch-windows = ["<Control>Tab"];
      switch-windows-backward = ["<Shift><Control>Tab"];
    };

    # 自定义媒体键
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Alt>space";
      command = "ulauncher-toggle";
      name = "Ulauncher";
    };
  };

  home.packages = with pkgs; [
    gnome.gnome-tweaks
    ulauncher
  ] ++ extensions;

  # dconf.settings = {
  #   "org/gnome/shell" = {
  #   #   favorite-apps = [
  #   #     "kitty.desktop"
  #   #     "wezterm.desktop"
  #   #     # "code.desktop"
  #   #     # "yesplaymusic.desktop"
  #   #     # "com.obsproject.Studio.desktop"
  #   #   ];
  #     disable-user-extensions = false;
  #     enabled-extensions =
  #       (builtins.map (extension: extension.extensionUuid) extensions) ++ [
  #           "kimpanel@kde.org"
  #           "dash-to-dock@micxgx.gmail.com"
  #           "just-perfection-desktop@just-perfection"
  #           "ding@rastersoft.com"
  #       ];
  #   };
  # };
}