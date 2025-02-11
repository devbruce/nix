{
  description = "nix-darwin flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    modules.url = "github:devbruce/nix/main?dir=nix-darwin/modules";
    
  };

  outputs = inputs@{ self, modules, nixpkgs, nix-darwin, nix-homebrew, home-manager, ... }:
  let
    username = "bruce";
  in {
    darwinConfigurations."all" = nix-darwin.lib.darwinSystem {
      specialArgs = { inherit self username; };
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
            user = username;
          };
        }
        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.extraSpecialArgs = {
            username = username;
          };
          home-manager.users.${username} = modules.outputs.home.default;
        }
      ];
    };
    darwinConfigurations."no-system-settings" = nix-darwin.lib.darwinSystem {
      specialArgs = { inherit self username; };
      modules = [
        modules.outputs.configs
        modules.outputs.fonts
        modules.outputs.packages
        modules.outputs.homebrew
        nix-homebrew.darwinModules.nix-homebrew {
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            user = username;
          };
        }
        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.extraSpecialArgs = {
            username = username;
          };
          home-manager.users.${username} = modules.outputs.home.default;
        }
      ];
    };
  };
}
