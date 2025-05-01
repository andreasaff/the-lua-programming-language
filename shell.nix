# npin: https://github.com/NixOS/nixpkgs/commit/3afd19146cac33ed242fc0fc87481c67c758a59e - pined to latest successful build on hydra - pined to latest successful build on hydra
{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/3afd19146cac33ed242fc0fc87481c67c758a59e.tar.gz") { } }:


pkgs.mkShell {
  buildInputs = with pkgs; [
    # slidev
    nodejs
    yarn

    # lua
    lua
    luaPackages.luacheck

    # latex
    texlive.combined.scheme-full
  ];
}
