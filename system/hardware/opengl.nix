{ pkgs, config, ... }:

{
  # nvidia
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true; # fixes corruption on resume from sleep
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };
  environment.systemPackages = with pkgs;
    [
      nvidia-vaapi-driver
    ];
  # OpenGL

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      # rocmPackages.clr.icd
      vaapiVdpau
      nvidia-vaapi-driver
    ];
  };
}
