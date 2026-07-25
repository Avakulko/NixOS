{
  flake.nixosModules.video = {config, ...}: {
    services.xserver.videoDrivers = ["nvidia"];
    hardware.graphics = {
      # enable = true;
      enable32Bit = true; # Steam and 32-bit OpenGL/Vulkan apps
    };

    hardware.nvidia = {
      open = false;

      modesetting.enable = true;

      powerManagement.enable = false;
      powerManagement.finegrained = false;

      nvidiaSettings = false;

      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}
