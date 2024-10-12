{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    escapeTime = 0;
    historyLimit = 50000;
    terminal = "tmux-256color";
    mouse = true;
    baseIndex = 1;
    catppuccin = {
      enable = true;
      flavor = "macchiato";
      extraConfig = ''
        # Disable catppuccin styling windows.
        set -g @catppuccin_window_status_style "basic"
        set -g @catppuccin_date_time_text "%Y-%m-%d %H:%M:%S"
        set -g @catppuccin_window_current_text "#{pane_current_path}"
        set -g status-left ""
        set -g  status-right "#{E:@catppuccin_status_application}"
        set -ag status-right "#{E:@catppuccin_status_session}"
        set -ag status-right "#{E:@catppuccin_status_user}"
        set -ag status-right "#{E:@catppuccin_status_host}"
        set -ag status-right "#{E:@catppuccin_status_date_time}"
      '';
    };
    plugins = with pkgs; [
      tmuxPlugins.cpu
      tmuxPlugins.sensible
      tmuxPlugins.yank
    ];
    extraConfig = ''
      set-option -sa terminal-overrides ",xterm*:Tc"
      set-option -g status-position top

      # Vim style pane selection
      bind -r h select-pane -L
      bind -r j select-pane -D
      bind -r k select-pane -U
      bind -r l select-pane -R

      # Vim style pane resize
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5

      # set vi-mode
      set-window-option -g mode-keys vi

      # keybindings
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
    '';
  };
}
