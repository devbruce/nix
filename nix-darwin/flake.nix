{
  description = "nix-darwin flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    modules.url = "github:devbruce/nix-modules/main?dir=nix-darwin";
    home-modules.url = "github:devbruce/nix-modules/main?dir=home";
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, nix-homebrew, home-manager, modules, home-modules, ... }:
  let
    # ==============================
    # == Variables
    # ==============================
    username = "bruce";
    # ==============================
    commonModules = [
      modules.outputs.configs
      modules.outputs.fonts
      modules.outputs.packages
    ];
    nixHomebrew = [
      modules.outputs.homebrew
      nix-homebrew.darwinModules.nix-homebrew {
        nix-homebrew = {
          enable = true;
          enableRosetta = true;
          user = username;
        };
      }
    ];
    homeManager = [
      home-manager.darwinModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "backup";
        home-manager.extraSpecialArgs = {
          username = username;
        };
        home-manager.users.${username} = home-modules.outputs.default;
      }
    ];
  in {
    darwinConfigurations."all" = nix-darwin.lib.darwinSystem {
      specialArgs = { inherit self username; };
      modules = commonModules ++ nixHomebrew ++ homeManager ++ [ modules.outputs.system ];
    };
    darwinConfigurations."no-system-settings" = nix-darwin.lib.darwinSystem {
      specialArgs = { inherit self username; };
      modules = commonModules ++ nixHomebrew ++ homeManager;
    };
  };
}
