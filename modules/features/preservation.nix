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
          "/etc/NetworkManager/system-connections"
        ];
        # users.andrew = {
        #   files = [];
        #   directories = [];
        # };
      };
    };
    # HACK: https://github.com/nix-community/preservation/pull/23
    boot.initrd.systemd.tmpfiles.settings.preservation."/sysroot/persist/etc/machine-id".f = {
      argument = "uninitialized";
    };
    systemd.services.systemd-machine-id-commit.unitConfig.ConditionFirstBoot = true;
  };
}
