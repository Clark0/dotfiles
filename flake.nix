{
  description = "dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager.url = "github:nix-community/home-manager";
    darwin.url = "github:LnL7/nix-darwin";
  };

  outputs = { self, nixpkgs, home-manager, darwin, ... }: let
    homeConfig = { username, homeDirectory }: import ./home-manager {
      inherit username homeDirectory;
    };

    mac = {
      username = "clark";
      homeDirectory = "/Users/clark";
    };

    linux = {
      username = "clark";
      homeDirectory = "/home/clark";
    };
  in {
    darwinConfigurations.Macbook = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        ./nix-darwin/default.nix
        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.clark = homeConfig mac;
        }
      ];
      specialArgs = mac;
    };

    homeConfigurations.Linux = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      modules = [
        (homeConfig linux)
      ];
    };
  };
}
