# From https://github.com/nix-community/home-manager/issues/2033#issuecomment-1848326144
# It doesn't even work out of the box with flakes...
# <https://github.com/nix-community/home-manager/issues/2033#issuecomment-1801557851>
#
# Include this in the `modules` passed to
# `inputs.home-manager.lib.homeManagerConfiguration`.
{ config, lib, pkgs, ...} :
let news=config.news;
in {
  news.display = "silent";
  news.json = lib.mkForce { };
  news.entries = lib.mkForce [ ];
}
