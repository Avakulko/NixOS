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
    };
  };
}
