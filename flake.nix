{
  description = "My first flake!";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, home-manager, nixpkgs, nixpkgs-unstable, ... }@inputs:
    let
      system = "x86_64-linux";
      allowUnfree = { nixpkgs.config.allowUnfree = true; };

      lib = nixpkgs.lib;

      pkgs = nixpkgs.legacyPackages.${system};
      unstable-pkgs = nixpkgs-unstable.legacyPackages.${system};

      nixpkgsConfig = {
        inherit system;
        config.allowUnfree = true;
      };


    in
    {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;
          modules = [ ./configuration.nix ];
        };
      };
      homeConfigurations = {

        thbabua = home-manager.lib.homeManagerConfiguration {

         extraSpecialArgs = { inherit unstable-pkgs; };

          inherit pkgs ;

          modules = [ ./home.nix ];
          

        };
      };
    };
}
