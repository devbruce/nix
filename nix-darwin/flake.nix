{
  description = "nix-darwin flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    modules.url = "path:./modules";
  };

  outputs = inputs@{ self, nix-darwin, nix-homebrew, modules, ... }: {
    darwinConfigurations."mac-v1" = nix-darwin.lib.darwinSystem {
      specialArgs = { inherit self; };
      modules = [
        modules.outputs.configs
        modules.outputs.fonts
        modules.outputs.packages
        modules.outputs.homebrew
        modules.outputs.system
        nix-homebrew.darwinModules.nix-homebrew {
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            user = "bruce";
          };
        }
      ];
    };
  };
}
