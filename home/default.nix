{
  config,
  pkgs,
  lib,
  nixpkgs-edge,
  ...
}:
let
  edge-pkgs = import nixpkgs-edge {
    system = pkgs.system;
    config = {
      allowUnfree = true;
    };
  };
in
{
  imports = [
    ../programs/ulauncher.nix
    ../programs/git.nix
    ../programs/zsh.nix
    ../programs/gnome.nix
    ../programs/fcitx5.nix
  ];

  home.username = "yuche";
  home.homeDirectory = "/home/yuche";

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
    ++ (with edge-pkgs; [
      code-cursor
      zed-editor
      mise
      # clash-verge-rev
    ]);

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
