{
  pkgs,
  username,
  ...
}: {
  home.packages = with pkgs; [
    hello
    neovim
    git
    tmux
    just
    fastfetch
    wget
    sshs
    htop
    btop
    zellij
    lazygit
    lazydocker
    bat
    eza
    zoxide
    delta
    ripgrep
    fd
    stow
    opencode
    nodejs
    # fonts
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];

  fonts.fontconfig.enable = true;

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
      mgr = {
        show_hidden = true;
        sort_by = "natural";
        sort_dir_first = true;
        sort_reverse = false;
      };
    };
  };
}
