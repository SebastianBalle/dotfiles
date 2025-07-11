{
  description = "Sebastian NixOS and Home-Manager flake";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs?ref=nixos-24.05";
    };
    nixpkgs-unstable = {
      url = "github:NixOS/nixpkgs?ref=nixpkgs-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, nixvim, nix-index-database } @ inputs:
    let
      user = "sebastianballe";
      
      # Custom packages
      pkgs-unstable = import nixpkgs-unstable {
        system = "aarch64-darwin";
        config.allowUnfree = true;
      };
      claude-code = pkgs-unstable.callPackage ./home/features/programs/claude-code/default.nix { };
    in {
      homeConfigurations = {
        mac = let
          system = "aarch64-darwin";
          pkgs-stable = import inputs.nixpkgs {
            system = system;
            config.allowUnfree = true;
          };
        in home-manager.lib.homeManagerConfiguration {
          extraSpecialArgs = {
            inherit inputs system user pkgs-stable claude-code;
          };
          pkgs = nixpkgs-unstable.legacyPackages.${system};

          modules = [
            { nixpkgs.config.allowUnfree = true; }
            nix-index-database.hmModules.nix-index
            ./home/${user}.nix
          ];
        };
      };

      nixosConfigurations = {
        nixos =
          let
            system = "x86_64-linux";
            pkgs = import inputs.nixpkgs {
              inherit system;
              config = { allowUnfree = true; };
            };
          in pkgs.lib.nixosSystem {
            inherit system;
            modules = [
              ./nixos/configuration.nix
              { nixpkgs.config.allowUnfree = true; }
              nix-index-database.nixosModules.nix-index
            ];
            specialArgs = { inherit inputs system user pkgs; };
          };
      };

      formatter = {
        aarch64-darwin = inputs.nixpkgs.legacyPackages.aarch64-darwin.nixpkgs-fmt;
        x86_64-linux = inputs.nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
      };
    };
}