{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    wrapper-modules.url = "github:BirdeeHub/nix-wrapper-modules";

    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kanata-switcher = {
      url = "github:7mind/kanata-switcher";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-cli.url = "github:nix-community/nixos-cli";
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} (inputs.import-tree ./modules);
}
