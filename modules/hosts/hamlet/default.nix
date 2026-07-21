{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.Hamlet = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      # Include the results of the hardware scan.
      self.nixosModules.hardware

      inputs.disko.nixosModules.disko
      self.diskoConfigurations.Hamlet

      self.nixosModules.configuration
    ];
  };
}
