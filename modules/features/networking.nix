{
  flake.nixosModules.networking = {pkgs, ...}: {
    # Configure network connections interactively with nmcli or nmtui.
    networking.networkmanager.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    networking.firewall.enable = false;

    programs.tcpdump.enable = true;

    programs.amnezia-vpn.enable = true;
    programs.throne = {
      enable = true;
      tunMode = {
        enable = true;
        setuid = true;
      };
    };

    environment.systemPackages = with pkgs; [
      wireshark
      sing-box
      # gui-for-singbox
    ];
    programs.wireshark.enable = true;
    users.users.andrew.extraGroups = ["wireshark"];
  };
}
