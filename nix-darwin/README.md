# [nix-darwin](https://github.com/LnL7/nix-darwin) for macOS

> [!NOTE]  
> nix-darwin: Nix modules for darwin, `/etc/nixos/configuration.nix` for macOS.

## 🔹 Remote Modules

- [`devbruce/nix-modules: nix-darwin`](https://github.com/devbruce/nix-modules/tree/main/nix-darwin)
- [`devbruce/nix-modules: home`](https://github.com/devbruce/nix-modules/tree/main/home)

<br>

## 🛠️ Prerequisites

- To install applications from the App Store, you must be signed in with an Apple account on macOS

- Install Xcode Command Line Tools

```bash
xcode-select --install
```

<br>

## ⌘ Command Examples

> [!TIP]  
> Copy [`../.config/nix/nix.conf`](../.config/nix/nix.conf) to `${HOME}`  
> (→ Omit `--extra-experimental-features "nix-command flakes"`)

- Initialize nix-darwin flake file

```bash
nix flake init -t nix-darwin --extra-experimental-features "nix-command flakes"
```

- Install `darwin-rebuild` & apply Nix Flake configuration

```bash
nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake .#all
```

- Apply the Nix Flake configuration

```bash
darwin-rebuild switch --flake .#all
```

- Update `flake.lock`

```bash
nix flake update --flake .
```

<br>

## 📝 Shell Configuration File

The `.zshrc` file generated via [Home Manager using Nix](https://github.com/nix-community/home-manager) is set to read-only.  
Consequently, if an installation script attempts to modify `.zshrc` directly, the changes should instead be made to `.zshrc_extra`, which is sourced by `.zshrc`.

Below is an example of how to update the installation script to apply configuration changes to `.zshrc_extra` instead of `.zshrc`.

<details>
  <summary>✨ Examples(Click to View)</summary><br>

- [nvm](https://github.com/nvm-sh/nvm)

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | sed 's/\.zshrc/\.zshrc_extra/g' | bash
```

- [sdkman](https://sdkman.io/)

```bash
curl -s "https://get.sdkman.io" | sed 's/\.zshrc/\.zshrc_extra/g' | bash
```

</details><br>

<br>

## 🌟 Post Installation

- [`./post_installer.sh`](./post_installer.sh): An interactive script for additional environment setup not managed by Nix

```bash
bash post_instller.sh
```
