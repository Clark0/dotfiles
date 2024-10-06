{
  config,
  pkgs,
  username,
  useremail,
  homeDirectory,
  ...
}: {
  home.packages = with pkgs; [
    hello
    neovim
    git
    just
    neofetch
    wget
    sshs
    htop
    zellij
    lazygit
    bat
    eza
    zoxide
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".config/alacritty".source = ./config/alacritty;
    ".config/zellij".source = ./config/zellij;
    ".vimrc".source = ./config/vim/vimrc;
    ".config/tmux".source = ./config/tmux;
    ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/dotfiles/home-manager/config/zsh/zshrc";
  };

  programs.git = {
    enable = true;
    lfs.enable = true;

    userName = username;
    userEmail = useremail;
  };

  # programs = {
  #   # modern vim
  #   neovim = {
  #     enable = true;
  #     defaultEditor = true;
  #     vimAlias = true;
  #   };
  # };
}
