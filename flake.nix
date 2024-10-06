{
  description = "My Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    home-manager,
    ...
  }: let
    # TODO: replace with actual values
    specialArgs = {
      username = "clark";
      useremail = "caoliu98@yahoo.com";
      homeDirectory = "/Users/clark";
    };

    specialArgsLinux = {
      username = "clark";
      useremail = "caoliu98@yahoo.com";
      homeDirectory = "/home/clark";
    };
  in {
    darwinConfigurations.Macbook = nix-darwin.lib.darwinSystem {
      inherit specialArgs;
      system = "aarch64-darwin";
      modules = [
        ./nix-darwin

        # home manager
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = specialArgs;
          home-manager.users.${specialArgs.username} = import ./home-manager;
        }
      ];
    };

    homeConfigurations = {
      Macbook = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {system = "aarch64-darwin";};
        modules = [
          ./home-manager
        ];
        extraSpecialArgs = specialArgs;
      };
    };

    homeConfigurations = {
      Linux = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {system = "x86_64-linux";};
        modules = [
          ./home-manager
        ];
        extraSpecialArgs = specialArgsLinux;
      };
    };
  };
}
