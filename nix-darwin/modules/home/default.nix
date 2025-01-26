{ config, pkgs, username, ... }: {
    home.stateVersion = "24.11";
    programs.home-manager.enable = true;
    home.username = username;
    home.homeDirectory = pkgs.lib.mkForce "/Users/${username}";
    
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        shellAliases = {
            l = "eza -al --icons=auto";
            clear-empty-dirs = "find . -type d -empty -delete";
            clear-caches = "find . | grep -E \"(__pycache__|\.pyc|\.pyo|\.DS_Store$)\" | xargs rm -rf";
        };
        initExtra = ''
        eval "$(zoxide init zsh)"
        '';
    };
    home.file.".zshrc".text = ''
        echo "Zsh configuration loaded from Nix!"
    '';
}
