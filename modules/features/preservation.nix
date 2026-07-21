{inputs, ...}: {
  flake.nixosModules.preservation = {
    imports = [inputs.preservation.nixosModules.default];
    preservation = {
      enable = true;
      preserveAt."/persist" = {
        files = [
          {
            file = "/etc/machine-id";
            inInitrd = true;
          }
        ];
        directories = [
          "/var/lib/systemd/timers"
          "/var/lib/nixos"
          "/var/lib/bluetooth"
          "/etc/NetworkManager/system-connections"
          "/var/log"
          # "/tmp"
        ];
        users.andrew = {
          files = [];
          directories = [];
        };
      };
    };
  };
}
