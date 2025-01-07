{
  config,
  pkgs,
  username,
  useremail,
  homeDirectory,
  ...
}: let
  symlink = config.lib.file.mkOutOfStoreSymlink;
in {
  home.packages = with pkgs; [
    hello
    neovim
    git
    tmux
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
    ripgrep
    fd
  ];

  # Managing dotfiles
  home.file = {
    ".config/alacritty".source = symlink "${homeDirectory}/dotfiles/home-manager/config/alacritty";
    ".config/zellij".source = symlink "${homeDirectory}/dotfiles/home-manager/config/zellij";
    ".vimrc".source = symlink "${homeDirectory}/dotfiles/home-manager/config/vim/vimrc";
    ".zshrc".source = symlink "${homeDirectory}/dotfiles/home-manager/config/zsh/zshrc";
    ".config/nvim".source = symlink "${homeDirectory}/dotfiles/home-manager/config/nvim";
  };

  programs.git = {
    enable = true;
    lfs.enable = true;

    userName = username;
    userEmail = useremail;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.yazi = {
    enable = true;
    settings = {
      show_hidden = true;
      sort_dir_first = true;
    };
  };
}
