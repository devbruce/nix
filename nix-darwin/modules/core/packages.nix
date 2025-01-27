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
    pyenv
    poetry
    virtualenv
    pipx
    rbenv
  ];
}
