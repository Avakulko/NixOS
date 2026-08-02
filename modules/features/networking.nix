{inputs, ...}: {
  flake.nixosModules.networking = {pkgs, ...}: let
    pkgsThrone = import inputs.nixpkgs-throne {
      inherit (pkgs.stdenv.hostPlatform) system;
    };
  in {
    # Configure network connections interactively with nmcli or nmtui.
    networking.networkmanager.enable = true;

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    networking.firewall.enable = false;

    programs.tcpdump.enable = true;
    programs.sniffnet.enable = true;

    programs.amnezia-vpn.enable = true;
    programs.throne = {
      enable = true;
      tunMode = {
        enable = true;
        setuid = true;
      };
      package = pkgsThrone.throne;
    };

    environment.systemPackages = with pkgs; [
      wireshark
      inputs.openflakes.packages.x86_64-linux.sing-box-pre
    ];
    programs.wireshark.enable = true;
    users.users.andrew.extraGroups = ["wireshark"];
  };
}
