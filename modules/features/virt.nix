{
  flake.nixosModules.virt = {
    virtualisation.podman.enable = true;
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;
    users.users.andrew.extraGroups = ["libvirtd" "kvm"];
  };
}
