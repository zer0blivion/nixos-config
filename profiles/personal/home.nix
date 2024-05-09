{ config, pkgs, userSettings, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = userSettings.username;
  home.homeDirectory = "/home/"+userSettings.username;

  programs.home-manager.enable = true;

  imports = [ ../work/home.nix # Personal is essentially work system + games
              ../../user/app/games/games.nix # Various videogame apps
            ];

  home.stateVersion = "22.11"; # Please read the comment before changing.

  home.file = {
      # Disable HTTP2 to improve steam download speeds
      ".local/share/Steam/steam_dev.cfg" = {
        text = ''
          @nClientDownloadEnableHTTP2PlatformLinux 0
          @fDownloadRateImprovementToAddAnotherConnection 1.0
        '';
      };
  };



  home.packages = with pkgs; [
    # Core
    zsh
    alacritty
    librewolf
    brave
    dmenu
    rofi
    git
    syncthing

    # Media
    tuxpaint
    # discord
    vesktop
    telegram-desktop
    vscode-fhs
  ];

  xdg.enable = true;
  xdg.userDirs = {
    extraConfig = {
      XDG_GAME_DIR = "${config.home.homeDirectory}/Media/Games";
      XDG_GAME_SAVE_DIR = "${config.home.homeDirectory}/Media/Game Saves";
    };
  };

}
