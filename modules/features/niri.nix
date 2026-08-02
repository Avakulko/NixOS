# TODO: smart gaps
{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.niri = moduleWithSystem ({
    pkgs,
    self',
    ...
  }: {
    programs.niri = {
      enable = true;
      package = self'.packages.niri;
      useNautilus = true;
    };
    environment.systemPackages = with pkgs; [
      xwayland-satellite
    ];
  });
  perSystem = {
    pkgs,
    lib,
    self',
    ...
  }: {
    packages.niri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      extraSettings = [
        # {include = ./some/pure/path;}
        {include = [{optional = true;} "/home/andrew/.config/niri/config.kdl"];}
      ];
      settings = {
        prefer-no-csd = _: {};
        input = {focus-follows-mouse = _: {props = {max-scroll-amount = "0%";};};};
        binds = {
          "Mod+Return".spawn-sh = lib.getExe self'.packages.kitty;
          "Mod+F".maximize-column = _: {};

          "Mod+H".focus-column-left = _: {};
          "Mod+Shift+H".move-column-left = _: {};

          "Mod+L".focus-column-right = _: {};
          "Mod+Shift+L".move-column-right = _: {};

          "Mod+J".focus-workspace-down = _: {};
          "Mod+Shift+J".move-column-to-workspace-down = _: {};

          "Mod+K".focus-workspace-up = _: {};
          "Mod+Shift+K".move-column-to-workspace-up = _: {};

          "Mod+v".toggle-window-floating = _: {};
          "Mod+Shift+Slash".show-hotkey-overlay = _: {};
          "Mod+Shift+P".screenshot = _: {};
          "Mod+Tab".toggle-overview = _: {};
          "Mod+Q".close-window = _: {};
        };
      };
    };
  };
}
