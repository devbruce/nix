# nix

- Nix: <https://nixos.org>
- nix-darwin: <https://github.com/LnL7/nix-darwin>  

> [!NOTE]  
> nix-darwin: Nix modules for darwin, `/etc/nixos/configuration.nix` for macOS.

<br>

## ⌘ Commands

> [!TIP]  
> Copy [`.config/nix/nix.conf`](.config/nix/nix.conf) to `${HOME}`  
> (→ Omit `--extra-experimental-features "nix-command flakes"`)

### ✔️ Initialize nix-darwin flake file

```bash
nix flake init -t nix-darwin --extra-experimental-features "nix-command flakes"
```

### ✔️ Install `darwin-rebuild` & apply Nix Flake configuration

```bash
nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ${NixFlakeFileDirPath}#${FlakeOutputName}
```

### ✔️ Apply the Nix Flake configuration

```bash
darwin-rebuild switch --flake ${NixFlakeFileDirPath}#${FlakeOutputName}
```

### ✔️ Update flake.lock

```bash
nix flake update --flake ${NixFlakeFileDirPath}
```
