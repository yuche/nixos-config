{
  config,
  pkgs,
  lib,
  edgePkgs,
  ...
}:

{
  imports = [ ./gnome.nix ];

  home.username = "yuche";
  home.homeDirectory = "/home/yuche";

  # 直接将当前文件夹的配置文件，链接到 Home 目录下的指定位置
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # 递归将某个文件夹中的文件，链接到 Home 目录下的指定位置
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # 递归整个文件夹
  #   executable = true;  # 将其中所有文件添加「执行」权限
  # };

  # 直接以 text 的方式，在 nix 配置文件中硬编码文件内容
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # 通过 home.packages 安装一些常用的软件
  home.packages =
    with pkgs;
    [
      # archives
      zip
      xz
      unzip
      p7zip

      # utils
      ripgrep # recursively searches directories for a regex pattern
      jq # A lightweight and flexible command-line JSON processor
      lsd # A modern replacement for ‘ls’
      fzf # A command-line fuzzy finder

      # networking tools
      mtr # A network diagnostic tool
      iperf3
      dnsutils # `dig` + `nslookup`

      # misc
      file
      which
      tree

      # mailspring
      _1password-gui
      ulauncher
      # steam
    ]
    ++ (with edgePkgs; [
      code-cursor
      zed-editor
      mise
      # clash-verge-rev
    ]);

  systemd.user.services.ulauncher = {
    Unit = {
      Description = "Linux Application Launcher";
      Documentation = [ "https://ulauncher.io/" ];
    };

    Service = {
      Type = "simple";
      Restart = "always";
      RestartSec = 1;
      ExecStart = pkgs.writeShellScript "ulauncher-env-wrapper.sh" ''
        export PATH="''${XDG_BIN_HOME}:$HOME/.nix-profile/bin:/etc/profiles/per-user/$USER/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin"
        export GDK_BACKEND=x11
        exec ${pkgs.ulauncher}/bin/ulauncher --hide-window
      '';
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    antidote.enable = true;
    antidote.plugins = [
      "zdharma-continuum/fast-syntax-highlighting"
      "zsh-users/zsh-autosuggestions"
      "spaceship-prompt/spaceship-prompt"
    ];
    initExtra = ''
      bindkey -e
      bindkey "^[[H" beginning-of-line
      bindkey "^[[F" end-of-line
      bindkey '^[c' send-break
      eval "$(mise activate zsh --shims)"
      FZF_ALT_C_COMMAND= source <(fzf --zsh)
      bindkey -M emacs '^[r' fzf-history-widget
      bindkey -M vicmd '^[r' fzf-history-widget
      bindkey -M viins '^[r' fzf-history-widget
    '';
    shellAliases = {
      ll = "lsd -l -a";
      update = "sudo nixos-rebuild switch --flake ~/nix-config#nixos";
      hm = "home-manager switch --flake ~/nix-config#yuche";
      cl = "clear";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
  };

  # git 相关配置
  programs.git = {
    enable = true;
    userName = "yuche";
    userEmail = "i@yuche.me";
  };
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
