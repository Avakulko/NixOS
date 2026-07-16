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
  flake.nixosConfigurations.agent = inputs.nixpkgs.lib.nixosSystem {
    modules = [self.nixosModules.myMachineConfiguration];
    pkgs.stdenv.hostPlatform = inputs.nixpkgs.lib.mkDefault "x86_64-linux";
  };
}
