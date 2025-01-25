{ ... }: {
  homebrew = {
    enable = true;
    onActivation.cleanup = "zap";
    brews = [
      "mas"
      "tfenv"
      "helm"
      "podman"
      # =======================
      # pyenv dependencies
      # > Ref: https://github.com/pyenv/pyenv/wiki
      # =======================
      "openssl"
      "readline"
      "sqlite3"
      "xz"
      "zlib"
      "tcl-tk@8"
      # =======================
    ];
    casks = [
      "google-chrome"
      "warp"
      "raycast"
      "visual-studio-code"
      "podman-desktop"
      "postman"
      "drawio"
    ];
    masApps = {
      "Magnet" = 441258766;
      "ScreenBrush" = 1233965871;
      "Yoink" = 457622435;
    };
  };
}
