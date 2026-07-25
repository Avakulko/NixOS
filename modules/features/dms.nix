{inputs, ...}: {
  flake.nixosModules.dms = {
    imports = [
      inputs.dms.nixosModules.greeter
      inputs.dms.nixosModules.dank-material-shell
    ];
    programs.dank-material-shell = {
      enableCalendarEvents = false; # BUG
      enable = true;
      systemd = {
        enable = true;
        restartIfChanged = true;
      };
      greeter = {
        compositor = {
          name = "niri";
        };
        enable = true;
      };
    };
  };
}
