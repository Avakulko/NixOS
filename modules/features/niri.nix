{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.niri = {
    pkgs,
    lib,
    ...
  }: {
    programs.niri = {
      enable = true;
      # package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
  };
  # perSystem =
  # {
  # pkgs,
  # lib,
  # self',
  # ...
  # }:
  # {
  # packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
  # inherit pkgs;
  # settings = {
  # 	binds = {
  # 		"Mod+Return".spawn-sh = lib.getExe pkgs.kitty;
  # 	};
  # };
  # };
  # };
}
