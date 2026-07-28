{inputs, ...}: {
  flake.nixosModules.herdr = {pkgs, ...}: {
    # TODO: declarative config
    environment.systemPackages = [
      pkgs.jq # Needed for https://github.com/paulbkim-dev/vim-herdr-navigation
      pkgs.herdr
    ];
  };
}
