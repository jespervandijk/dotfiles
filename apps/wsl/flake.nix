{
  description = "Wsl environment";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  outputs = { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;  # Allow unfree packages
      };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          git
          nushell
          chezmoi
          mise
          starship
          carapace
          dotnetCorePackages.dotnet_9.sdk
          docker
        ];
      };
    };
}