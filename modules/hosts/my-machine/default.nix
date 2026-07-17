{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations.myMachine = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      # Include the results of the hardware scan.
      self.nixosModules.myMachineHardware

      self.nixosModules.myMachineConfiguration
    ];
  };
}
