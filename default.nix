with import <nixpkgs> {
  overlays = [
    # set up the rust overlay for up-to-date rust versions
    (import (builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz))
  ];
};
let
  my_openscad = stdenv.mkDerivation rec {
    pname = "openscad";
    version = "2015.03";
    src = fetchFromGitHub {
      owner = "openscad";
      repo = "openscad";
      rev = "${pname}-${version}";
      sha256 = "1qz384jqgk75zxk7sqd22ma9pyd94kh4h6a207ldx7p9rny6vc5l";
    };

    nativeBuildInputs = with pkgs; [ bison flex pkgconfig gettext qt5.qmake ];
    buildInputs = with pkgs; ([
        eigen boost glew opencsg cgal mpfr gmp glib
        harfbuzz lib3mf libzip double-conversion freetype fontconfig
        qt5.qtbase qt5.qtmultimedia libsForQt5.qscintilla
      ] ++ stdenv.lib.optional stdenv.isLinux libGLU_combined);
        # ++ stdenv.lib.optional stdenv.isDarwin qtmacextras);

    qmakeFlags = [ "VERSION=${version}" ];

    # src/lexer.l:36:10: fatal error: parser.hxx: No such file or directory
    # enableParallelBuilding = false; # true by default due to qmake

    postInstall = stdenv.lib.optionalString stdenv.isDarwin ''
      mkdir $out/Applications
      mv $out/bin/*.app $out/Applications
      rmdir $out/bin || true
      mv --target-directory=$out/Applications/OpenSCAD.app/Contents/Resources \
        $out/share/openscad/{examples,color-schemes,locale,libraries,fonts}
      rmdir $out/share/openscad
    '';
  };
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
    my_openscad
    cgal
    boost
    gmp
    mpfr
  ];
  RUST_SRC_PATH = "${rust}/lib/rustlib/src/rust/src";
}
