{ config, pkgs, ... }:

{
  imports = [ ./pipewire.nix
              ./dbus.nix
              ./gnome-keyring.nix
              ./fonts.nix
            ];

  environment.systemPackages = with pkgs;
    [ wayland waydroid gnome.gdm
      (sddm-chili-theme.override {
        themeConfig = {
          background = config.stylix.image;
          ScreenWidth = 1920;
          ScreenHeight = 1080;
          blur = true;
          recursiveBlurLoops = 3;
          recursiveBlurRadius = 5;
        };})
    ];
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  # Configure xwayland
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
      options = "caps:escape";
    };
    displayManager.sddm = {
      enable = true;
      autoNumlock = true;
      wayland.enable = true;
      # enableHidpi = true;
      theme = "chili";
      package = pkgs.sddm;
    };
  };
}
