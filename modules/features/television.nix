{
  flake.nixosModules.television = {pkgs, ...}: {
    programs.television = {
      enable = true;
      enableBashIntegration = true;
    };
    environment.systemPackages = with pkgs; [fd ripgrep bat];
  };
}
