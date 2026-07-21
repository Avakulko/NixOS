{
  flake.diskoConfigurations.Hamlet = {
    fileSystems."/var/log".neededForBoot = true;
    fileSystems."/var/lib".neededForBoot = true;
    fileSystems."/persist".neededForBoot = true;

    disko.devices.nodev = {
      "/" = {
        fsType = "tmpfs";
        mountOptions = [
          "size=25%" # Maximum amount of RAM root can take
          "mode=755"
        ];
      };
    };

    disko.devices.disk.main = {
      type = "disk";
      device = "/dev/nvme0n1";

      content.type = "gpt";

      content.partitions.ESP = {
        name = "ESP";
        label = "boot";
        size = "1G";
        type = "EF00";
        content = {
          type = "filesystem";
          format = "vfat";
          mountpoint = "/boot";
          mountOptions = ["defaults"];
        };
      };

      content.partitions.main = {
        name = "main";
        size = "100%";
        content = {
          type = "btrfs";
          extraArgs = ["-L" "nixos" "-f"];
          subvolumes = {
            "/home" = {
              mountpoint = "/home";
              mountOptions = ["subvol=home" "compress=zstd" "noatime"];
            };
            "/nix" = {
              mountpoint = "/nix";
              mountOptions = ["subvol=nix" "compress=zstd" "noatime"];
            };
            "/log" = {
              mountpoint = "/var/log";
              mountOptions = ["subvol=log" "compress=zstd" "noatime"];
            };
            "/lib" = {
              mountpoint = "/var/lib";
              mountOptions = ["subvol=lib" "compress=zstd" "noatime"];
            };
            "/persist" = {
              mountpoint = "/persist";
              mountOptions = ["subvol=persist" "compress=zstd" "noatime"];
            };
            "/persist/swap" = {
              mountpoint = "/persist/swap";
              mountOptions = ["subvol=swap" "noatime" "nodatacow" "compress=no"];
              swap.swapfile.size = "18G";
            };
          };
        };
      };
    };
  };
}
