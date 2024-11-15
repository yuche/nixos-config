{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "yuche";
    userEmail = "i@yuche.me";
  };
}
