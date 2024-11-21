{ stdenv
, lib
, fetchFromGitHub
, gnat
, gprbuild
}:

stdenv.mkDerivation rec {
  pname = "vss";
  version = "25.0.0";

  src = fetchFromGitHub {
    name = "vss";
    owner = "AdaCore";
    repo = "VSS";
    rev = "v${version}";
    sha256 = "XD5orxMGXFBVvc9UjSLXGb0yP5tDGNubykQ1b0B9o/k=";
  };

  nativeBuildInputs = [
    gnat
    gprbuild
  ];

  propagatedBuildInputs = [
    gprbuild
  ];

  buildPhase = ''
    make PREFIX=${placeholder "out"} DESTDIR="" build-libs-static
  '';

  installPhase = ''
    make PREFIX=${placeholder "out"} DESTDIR="" install-libs-static
  '';
}
