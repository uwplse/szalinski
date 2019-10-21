with import <nixpkgs> {
  overlays = [
    # set up the rust overlay for up-to-date rust versions
    (import (builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz))
  ];
};
let
  rustChannel = rustChannelOf { channel = "1.38.0"; };
  rust = rustChannel.rust;
in
pkgs.mkShell {
  name = "szalinski-egg";
  buildInputs = [
    rust
    (python3.withPackages (pp: [
      pp.matplotlib
    ]))
    cgal
    boost
    gmp
    mpfr
  ];
  RUST_SRC_PATH = "${rust}/lib/rustlib/src/rust/src";
}
