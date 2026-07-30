{
  flake.nixosModules.video = {config, ...}: {
    services.xserver.videoDrivers = ["nvidia"];
    hardware.graphics = {
      enable32Bit = true; # Steam and 32-bit OpenGL/Vulkan apps
    };

    hardware.nvidia = {
      open = true;

      modesetting.enable = true;

      powerManagement.enable = true; # HACK: fixes nvidia suspend/resume
      powerManagement.finegrained = false;

      nvidiaSettings = false;

      branch = "bleeding_edge";
    };
  };
}
