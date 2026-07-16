{inputs, ...}: {
  flake.nixosModules.nautilus = {pkgs, ...}: {
    environment.systemPackages = [pkgs.nautilus];

    # Doesn't work with zellij
    programs.nautilus-open-any-terminal = {
      enable = true;
      terminal = "kitty";
    };

    services.gnome.sushi.enable = true;
  };
}
