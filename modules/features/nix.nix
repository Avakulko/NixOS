{
  inputs,
  config,
  ...
}: {
  flake.nixosModules.nix = {pkgs, ...}: {
    imports = [inputs.nixos-cli.nixosModules.nixos-cli];
    programs.nixos-cli = {
      enable = true;
      option-cache.enable = true;
      settings = {
        config_location = "/home/andrew/myNixOS";
        color = true;
        apply = {
          use_nom = true;
          reexec_as_root = true;
        };
      };
    };
    nix.settings.experimental-features = ["nix-command" "flakes"];
    nix.settings = {
      substituters = ["https://watersucks.cachix.org"];
      trusted-public-keys = [
        "watersucks.cachix.org-1:6gadPC5R8iLWQ3EUtfu3GFrVY7X6I4Fwz/ihW25Jbv8="
      ];
    };
    environment.systemPackages = with pkgs; [
      nix-output-monitor
      nix-search-tv
      nix-inspect
    ];
    programs.nh = {
      enable = true;
      flake = "/home/andrew/myNixOS"; # "$HOME/myNixOS/" doesnt work for some reason
    };
  };
}
