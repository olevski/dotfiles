pkgs: {
  # NOTE: If you do not use this then you have to import nix pkgs in the derivation itself
  # callPackage takes care of adding things properly
  # Managed to glean this from:
  # https://discourse.nixos.org/t/including-local-packages-in-home-manager-configuration/38346
  # https://github.com/dietmarw/hm-localpkgs
  poetry-polylith-plugin = pkgs.callPackage ./poetry-polylith-plugin { };
}
