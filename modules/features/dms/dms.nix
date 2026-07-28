{inputs, ...}: {
  flake.nixosModules.dms = {pkgs, ...}: {
    # TODO: update dms.json
    # add kde connect plugin
    programs.dms-shell = {
      enable = true;
      enableVPN = false;
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
    environment.systemPackages = with pkgs; [
      # tela-circle-icon-theme
      fluent-icon-theme
      bibata-cursors
    ];
  };
}
