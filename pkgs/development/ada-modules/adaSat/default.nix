{ stdenv
, lib
, fetchFromGitHub
, gnat
, gprbuild-boot
}:

stdenv.mkDerivation rec {
  pname = "AdaSat";
  version = "25.0.0";

  src = fetchFromGitHub {
    name = "AdaSat";
    owner = "AdaCore";
    repo = "AdaSat";
    rev = "v${version}";
    sha256 = "sha256-ahT3HP2n866wFZmsh1nKLz8tVuIYWgInE2HsHroCihk=";
  };

  nativeBuildInputs = [
    gnat
    gprbuild-boot
  ];

  makeFlags = [
    "BUILD_MODE=prod"
    "LIBRARY_TYPE=static"
    "BUILD_DIR=."
    "INSTALL_DIR=${placeholder "out"}"
  ];

  patches = [ ./makefile.patch ];

  meta = with lib; {
    description = "Implementation of a DPLL-based SAT solver in Ada";
    homepage = "https://github.com/AdaCore/adasat";
    platforms = platforms.all;
  };
}
