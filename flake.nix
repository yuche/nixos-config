{
  description = "Yuche's NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-edge.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    librime-lua = {
      url = "github:hchunhui/librime-lua?rev=b210d0cfbd2a3cc6edd4709dd0a92c479bfca10b";
      flake = false;
    };

  };

  outputs =
    {
      nixpkgs,
      nixpkgs-edge,
      home-manager,
      ...
    }@inputs:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit nixpkgs-edge inputs;
        };
        modules = [
          ./configuration.nix
          ./locale.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.yuche =
              { pkgs, ... }:
              {
                nixpkgs.config.allowUnfree = true;
                imports = [ ./home ];
              };

            home-manager.extraSpecialArgs = inputs;
          }
        ];
      };

      # homeConfigurations."yuche" = home-manager.lib.homeManagerConfiguration {
      #   pkgs = import nixpkgs {
      #     system = "x86_64-linux";
      #     config.allowUnfree = true;
      #   };
      #   extraSpecialArgs = {
      #     edgePkgs = import nixpkgs-edge {
      #       system = "x86_64-linux";
      #       config.allowUnfree = true;
      #     };
      #   };
      #   modules = [ ./home ];
      # };
    };
}
