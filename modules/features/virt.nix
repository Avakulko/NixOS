{
  flake = {
    nixosModules.virt = {pkgs, ...}: {
      virtualisation.podman.enable = true;

      virtualisation.libvirtd = {
        enable = true;
        qemu.vhostUserPackages = [pkgs.virtiofsd];
      };
      programs.virt-manager.enable = true;
      users.users.andrew.extraGroups = ["libvirtd" "kvm"];
      #  BUG: vm-curator fails with no such file or directory /usr/share/OVMF/OVMF_CODE.fd

      # environment.systemPackages = with pkgs; [
      #   OVMF
      #   edk2-uefi-shell
      # ];
    };
  };
}
