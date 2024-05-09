{ pkgs, ... }:

{
  hardware.opengl.driSupport32Bit = true;
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };
  environment.systemPackages = [ pkgs.steam ];
}
