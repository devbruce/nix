#!/usr/bin/env bash

# List of installable items (poetry_plugin_shell을 poetry의 하위 항목처럼 표시)
OPTIONS=(
    " 📦 lazyvim ::LazyVim(Neovim setup powered by 💤 lazy.nvim to make it easy to customize and extend your config) < Ref: https://github.com/LazyVim/LazyVim >"
    " 📦 nvm ::NVM(Node Version Manager) < Ref: https://github.com/nvm-sh/nvm >"
    " 📦 sdkman ::SDKMAN!(The Software Development Kit Manager) < Ref: https://sdkman.io/ >"
    " 📦 pyenv_update ::pyenv plugin - pyenv-update  < Ref: https://github.com/pyenv/pyenv-update.git >"
    " 📦 poetry ::Poetry(via pipx) < Ref: https://python-poetry.org/ >"
    "   📦 poetry_plugin_shell ::Poetry plugin - shell < Ref: https://github.com/python-poetry/poetry-plugin-shell >"
)

# Get selected items using fzf
SELECTIONS=$(
    printf "%s\n" "${OPTIONS[@]}" | \
    fzf --multi \
        --bind "ctrl-a:toggle-all" \
        --prompt="Select items to install(Toggle ALL: <ctrl-a>): " \
        --preview="echo {} | awk -F '::' '{print \$2}'" \
        --delimiter="::" \
        --with-nth=1 \
        --layout=reverse-list \
        --height=50% \
    | sed 's/::/|/' \
    | cut -d '|' -f1
)
# Remove leading whitespace and prefix & postfix( 📦 / ) from dependencies
SELECTIONS=$(echo "$SELECTIONS" | sed 's/^ *//g' | sed 's/ 📦 //g' | sed 's/ //g')
if [ -z "$SELECTIONS" ]; then
    echo -e "\n* 🚫 No items selected for installation. Exiting...\n"
    exit 0
fi

# Convert selected items into an array
readarray -t SELECTED_OPTIONS <<< "$SELECTIONS"

# Ensure dependencies (poetry -> poetry_plugin_shell)
if [[ " ${SELECTED_OPTIONS[*]} " =~ " poetry_plugin_shell " ]] && [[ ! " ${SELECTED_OPTIONS[*]} " =~ " poetry " ]]; then
    echo "* ⚠️ 'poetry_plugin_shell' requires 'poetry'. Adding 'poetry' to selection."
    SELECTED_OPTIONS+=("poetry")
fi

# Define functions for installing selected items
install_lazyvim() {
    local target_dir="$HOME/.config/nvim"

    if [ -d "$target_dir" ]; then
        read -p "⚠️  LazyVim($target_dir) already exists. Remove and reinstall? (y/N): " response
        response=${response,,} # to lowercase
        if [[ "$response" != "y" ]]; then
            echo "🚫 LazyVim Installation cancelled."
            return
        fi
        rm -rf "$target_dir"
    fi

    git clone https://github.com/LazyVim/starter "$target_dir"
    rm -rf "$target_dir/.git"

    echo -e "\n >> ✅ Complete install_lazyvim \n"
}

install_nvm() {
    echo "# nvm (Ref: https://github.com/nvm-sh/nvm)" >> ~/.zshrc_extra
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | sed 's/\.zshrc/\.zshrc_extra/g' | bash
    echo -e "\n >> ✅ Complete install_nvm \n"
}

install_sdkman() {
    echo "# sdkman (Ref: https://sdkman.io/)" >> ~/.zshrc_extra
    curl -s "https://get.sdkman.io" | sed 's/\.zshrc/\.zshrc_extra/g' | bash
    echo -e "\n >> ✅ Complete install_sdkman \n"
}

install_pyenv_update() {
    git clone https://github.com/pyenv/pyenv-update.git $(pyenv root)/plugins/pyenv-update
    echo -e "\n >> ✅ Complete install_pyenv_update \n"
}

install_poetry() {
    pipx install poetry
    echo -e "\n >> ✅ Complete install_poetry \n"
}

install_poetry_shell() {
    poetry self add poetry-plugin-shell
    echo -e "\n >> ✅ Complete install_poetry_shell \n"
}

# Print selected items
echo -e "\n==============================="
echo -e " Selected Installation items "
for item in "${SELECTED_OPTIONS[@]}"; do
    echo -e "* 📦 $item"
done
echo -e "===============================\n"

# Ask for confirmation before proceeding
read -p "[❓] Proceed with the installation? (y/N): " CONFIRM
if [[ "$CONFIRM" != "y" ]]; then
    echo -e "\n* ❌ Installation cancelled. Exiting...\n"
    exit 0
fi

echo -e "\n-------------------------------"
echo -e "✨ Start installation"
echo -e "-------------------------------\n"

# Execute installation for selected items
for item in "${SELECTED_OPTIONS[@]}"; do
    case "$item" in
        "lazyvim") install_lazyvim ;;
        "nvm") install_nvm ;;
        "sdkman") install_sdkman ;;
        "pyenv_update") install_pyenv_update ;;
        "poetry") install_poetry ;;
        "poetry_plugin_shell") install_poetry_shell ;;
    esac
done

echo -e "\n* 🎉 Installation complete! 🎉\n"
