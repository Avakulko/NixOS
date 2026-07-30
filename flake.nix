{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    wrapper-modules = {
      url = "github:BirdeeHub/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    preservation.url = "github:nix-community/preservation";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kanata-switcher = {
      url = "github:7mind/kanata-switcher";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-cli.url = "github:nix-community/nixos-cli";

    openflakes.url = "github:aur3l14no/openflakes";
    nixpkgs-throne.url = "github:NixOS/nixpkgs/pull/529124/head";
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake {inherit inputs;} (inputs.import-tree ./modules);
}
