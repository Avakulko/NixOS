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
      package = self'.packages.niri.override {
        libdisplay-info = pkgs.libdisplay-info.overrideAttrs (finalAttrs: {
          version = "0.3.0";
          src = pkgs.fetchFromGitLab {
            domain = "gitlab.freedesktop.org";
            owner = "emersion";
            repo = "libdisplay-info";
            rev = finalAttrs.version;
            sha256 = "sha256-nXf2KGovNKvcchlHlzKBkAOeySMJXgxMpbi5z9gLrdc=";
          };
        });
      };
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
      settings = {
        prefer-no-csd = _: {};
        # layout = {
        # focus-ring = {};
        # };
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

          "Mod+Q".close-window = _: {};
        };
      };
    };
  };
}
