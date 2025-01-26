{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    oh-my-zsh
    zsh-syntax-highlighting
    zsh-autosuggestions
    zsh-history-substring-search
    zsh-powerlevel10k
    zoxide
    neofetch
    tree
    neovim
    tmux
    direnv
    eza
    fzf
    k9s
    minikube
    jq
    yq
    bat
    gh
    htop
    httpie
    pyenv
    poetry
    pipx
  ];
}
