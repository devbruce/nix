{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    neofetch
    eza
    tree
    neovim
    tmux
    k9s
    minikube
    jq
    yq
    gh
    htop
    httpie
    rbenv
    pyenv
    virtualenv
    pipx
  ];
}
