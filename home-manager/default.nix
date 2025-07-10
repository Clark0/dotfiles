{
  pkgs,
  username,
  homeDirectory,
  ...
}: {
  # import sub modules
  imports = [
    ./programs.nix
    # ./tmux.nix
    # ./zsh.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = username;
  home.homeDirectory = homeDirectory;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.sessionVariables = {
  };

  home.sessionPath = [
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
