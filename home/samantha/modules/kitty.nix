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
      clear_all_shortcuts = "yes";
    };

    keybindings = {
      # Tabs/windows
      "ctrl+alt+t" = "new_tab";
      "ctrl+alt+]" = "next_tab";
      "ctrl+alt+[" = "previous_tab";
      "ctrl+alt+w" = "close_window";

      # Splits
      "ctrl+alt+e" = "launch --location=hsplit";
      "ctrl+alt+n" = "launch --location=vsplit";

      # Navigation
      "ctrl+alt+h" = "neighboring_window left";
      "ctrl+alt+l" = "neighboring_window right";
      "ctrl+alt+k" = "neighboring_window up";
      "ctrl+alt+j" = "neighboring_window down";

      # Fullscreen
      "ctrl+alt+f" = "toggle_fullscreen";

      # New shell in cwd
      "ctrl+alt+enter" = "launch --cwd=current";

      # Font zoom 
      "ctrl+alt+plus" = "change_font_size all +1";
      "ctrl+alt+minus" = "change_font_size all -1";
      "ctrl+alt+0" = "change_font_size all 0";
    };
  };
}
