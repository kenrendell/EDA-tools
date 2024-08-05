# See https://discourse.nixos.org/t/transitioning-from-imperative-to-declarative-package-management-with-nix-alone/28728
# and https://nixos.org/manual/nixpkgs/stable/#sec-building-environment
{
  description = "Electronic Design Automation (EDA) tools for IC design";

  inputs = {
    flakey-profile.url = "github:lf-/flakey-profile";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, flakey-profile }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      {
        # Any extra arguments to mkProfile are forwarded directly to pkgs.buildEnv.
        #
        # Usage:
        # Switch to this flake:
        #   nix run .#profile.switch
        # Revert a profile change:
        #   nix run .#profile.rollback
        # Build, without switching:
        #   nix build .#profile
        packages.profile = flakey-profile.lib.mkProfile {
          inherit pkgs;
          paths = with pkgs; [
            xschem
            ngspice
            xyce
            xyce-parallel
            mpi
            ghdl
            iverilog
            gaw
            gtkwave
            magic-vlsi
            klayout
            xcircuit
            qucs-s
            kicad
            fritzing
          ];
        };
      });
}
