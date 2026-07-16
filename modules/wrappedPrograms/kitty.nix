{
  flake.wrappers.kitty = {wlib, ...}: {
    imports = [wlib.wrapperModules.kitty];
    config = {
      # map ctrl+c copy_or_interrupt
      font = {
        name = "JetBrains Mono";
        size = 20.0;
      };
      themeFile = "Catppuccin-Mocha";
      settings = {
        # Nerd Fonts v3.4.0. Also requires Noto Color Emoji installed
        symbol_map = "U+e000-U+e00a,U+e0a0-U+e0a2,U+e0a3,U+e0b0-U+e0b3,U+e0b4-U+e0c8,U+e0ca,U+e0cc-U+e0d7,U+e200-U+e2a9,U+e300-U+e3e3,U+e5fa-U+e6b7,U+e700-U+e8ef,U+ea60-U+ec1e,U+ed00-U+efce,U+f000-U+f2ff,U+f300-U+f381,U+f400-U+f533,U+f0001-U+f1af0 Symbols Nerd Font Mono";
        disable_ligatures = "cursor";
        copy_on_select = "yes";
        strip_trailing_spaces = "smart";
        update_check_interval = 0;
        confirm_os_window_close = 0;

        # Graphics
        background_opacity = 0.5;
        background_blur = 32;
        cursor_blink_interval = "0.5 ease-in-out";
        cursor_trail = 1;
      };
    };
  };
}
