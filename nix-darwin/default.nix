{
  username,
  homeDirectory,
  pkgs,
  lib,
  ...
}: {
  users.users."${username}" = {
    home = homeDirectory;
    description = username;
  };

  system.primaryUser = username;

  # enable flakes globally
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    auto-optimise-store = false;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = false;

  nix.package = pkgs.nix;

  # do garbage collection weekly to keep disk usage low
  nix.gc = {
    automatic = lib.mkDefault true;
    options = lib.mkDefault "--delete-older-than 7d";
  };

  home-manager.backupFileExtension = "backup";

  imports = [
    ./brew.nix
    ./system.nix
  ];
}
