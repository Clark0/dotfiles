{
  description = "My Darwin system flake";

  nixConfig = {
    substituters = [
      # Query the mirror of USTC first, and then the official cache.
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    nixpkgs,
    home-manager,
    catppuccin,
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
          catppuccin.homeManagerModules.catppuccin
        ];
        extraSpecialArgs = specialArgs;
      };
    };

    homeConfigurations = {
      Linux = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {system = "x86_64-linux";};
        modules = [
          ./home-manager
          catppuccin.homeManagerModules.catppuccin
        ];
        extraSpecialArgs = specialArgsLinux;
      };
    };
  };
}
