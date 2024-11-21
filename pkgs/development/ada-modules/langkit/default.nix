{ stdenv
, lib
, fetchFromGitHub
, python310
, gnat
, gprbuild-boot
, gnatcoll-core
, gnatcoll-iconv
, gnatcoll-gmp
, adasat
, prettier
, vss
}:
let
  python =
    python310.withPackages
      (ps: with ps;
      [
        mako
        pygments
        autopep8
        coverage
        docutils
        flake8
        funcy
        mccabe
        mypy
        pexpect
        ptyprocess
        pycodestyle
        pyflakes
        pytest
        railroad-diagrams
        sphinx-rtd-theme
        types-docutils
        # types-gdb
        yapf
        e3-core
      ]);
in

stdenv.mkDerivation rec {
  pname = "langkit";
  version = "25.0.0";

  src = fetchFromGitHub {
    name = "langkit";
    owner = "AdaCore";
    repo = "langkit";
    rev = "v${version}";
    sha256 = "GhYjrPpjxpIZLsKhiiAscpQNGAnDTeyr7oobSSrpzAc=";
  };

  nativeBuildInputs = [
    gnat
    gprbuild-boot
    gnatcoll-core
    gnatcoll-gmp
    gnatcoll-iconv
    adasat
    prettier
    vss
    python
  ];

  buildPhase = '' 
   python manage.py build-langkit-support --library-types=static
  '';

  installPhase = ''
    python manage.py install-langkit-support ${placeholder "out"} --library-types=static
  '';
}
