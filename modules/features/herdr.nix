{inputs, ...}: {
  flake.nixosModules.herdr = {pkgs, ...}: {
    # TODO: declarative config
    environment.systemPackages = [
      pkgs.herdr
    ];
  };
}
