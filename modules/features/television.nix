{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.television = moduleWithSystem ({
    self',
    pkgs,
    ...
  }: {
    programs.television = {
      enable = true;
      enableBashIntegration = true;
      package = self'.packages.television;
    };
    environment.systemPackages = with pkgs; [
      fd
      ripgrep
      bat
      nix-search-tv
    ];
  });
  perSystem = {pkgs, ...}: {
    packages.television = inputs.wrapper-modules.wrappers.television.wrap {
      inherit pkgs;
      channels = {
        nix = {
          metadata = {
            name = "nix";
            requirements = ["nix-search-tv"];
          };
          source = {
            command = "nix-search-tv print";
          };
          preview = {
            command = "nix-search-tv preview {}";
          };
        };
      };
    };
  };
}
