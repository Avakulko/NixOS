{inputs, ...}: {
  flake.nixosModules.dms = {pkgs, ...}: {
    programs.dms-shell = {
      enable = true;
      systemd = {
        enable = true;
        restartIfChanged = true;
      };
    };
    services.displayManager = {
      defaultSession = "niri"; # Required for autoLogin
      autoLogin = {
        enable = true;
        user = "andrew";
      };
      dms-greeter = {
        enable = true;
        compositor.name = "niri";
      };
    };
    environment.systemPackages = [
      pkgs.tela-circle-icon-theme
    ];
  };
}
