{
  description = "A Nix-flake based R development environment";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  outputs = { self, nixpkgs, flake-utils, ... }:

    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; let
          rpkgs = with rPackages; [
            Metrics
            dplyr
            forecast
            ggplot2
            imputeTS
            magrittr
            missMethods
            roxygen2
            testthat
            zoo
          ];
          my-r = rWrapper.override {
            packages = rpkgs;
          };
          my-rstudio = rstudioWrapper.override {
            packages = rpkgs;
          };
        in [
          my-r
          my-rstudio
        ];
      };
    });
}
