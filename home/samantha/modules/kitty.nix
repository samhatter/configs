{...}: {
  programs.kitty = {
    enable = true;

    font = {
      name = "IBM Plex Mono";
      size = 11;
    };

    themeFile = "gruvbox-dark";

    settings = {
      confirm_os_window_close = 0;
      enable_audio_bell = "no";
      cursor_shape = "beam";
      cursor_blink_interval = 0;
      background_opacity = "0.95";
      dynamic_background_opacity = "yes";
      inactive_text_alpha = "0.9";

      window_padding_width = 8;
      window_margin_width = 4;

      disable_ligatures = "never";

      copy_on_select = "yes";
      strip_trailing_spaces = "smart";
      scrollback_lines = 10000;
      detect_urls = "yes";
      open_url_modifiers = "ctrl";
      clipboard_control = "write-clipboard write-primary read-clipboard read-primary";

      repaint_delay = 8;
      input_delay = 2;
      sync_to_monitor = "yes";
    };

    keybindings = {
      # Tabs/windows
      "ctrl+shift+t" = "new_tab";
      "ctrl+shift+]" = "next_tab";
      "ctrl+shift+[" = "previous_tab";
      "ctrl+shift+w" = "close_window";

      # Splits
      "ctrl+shift+e" = "launch --location=hsplit";
      "ctrl+shift+n" = "launch --location=vsplit";

      # Navigation
      "ctrl+shift+h" = "neighboring_window left";
      "ctrl+shift+l" = "neighboring_window right";
      "ctrl+shift+k" = "neighboring_window up";
      "ctrl+shift+j" = "neighboring_window down";

      # Fullscreen
      "ctrl+shift+f" = "toggle_fullscreen";

      # New shell in cwd
      "ctrl+shift+enter" = "launch --cwd=current";

      # Font zoom
      "ctrl+alt+plus" = "change_font_size all +1";
      "ctrl+alt+minus" = "change_font_size all -1";
      "ctrl+alt+0" = "change_font_size all 0";

      # Let Neovim use Ctrl+Shift+=/- (no Kitty zoom interception)
      "ctrl+shift+equal" = "no_op";
      "ctrl+shift+plus" = "no_op";
      "ctrl+shift+minus" = "no_op";
    };
  };
}
