{ config, pkgs, ... }:
{
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
      cl = "clear";
      open = "xdg-open";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
  };
}
