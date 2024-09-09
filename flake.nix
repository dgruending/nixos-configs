{
  description = "Nixos config flake";

  inputs = {
    # Set NixOs stable as default
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    
    # Track unstable releases if needed
    # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Use unstable as default
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager follows latest stable NixOs release
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Add snowfall-lib for easier structuring
    # The name "snowfall-lib" is required due to how Snowfall Lib processes your
    # flake's inputs.
    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # outputs = { self, nixpkgs, home-manager, nixpkgs-unstable, ... }@inputs:
  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {    
      nixosConfigurations.nixToSee = lib.nixosSystem {
        specialArgs = {inherit inputs;};
        inherit system;
        modules = [
          ./hosts/home_station/configuration.nix
        ];
      };
      homeConfigurations."dkersting" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./homes/dkersting/home.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs = {inherit inputs;};
      };

      homeConfigurations."fkersting" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./homes/fkersting/home.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs = {inherit inputs;};
      };
    };
}
