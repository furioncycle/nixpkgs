{ stdenv
, lib
, fetchFromGitHub
, gprbuild
, gnat
, gnatcoll-core
, vss
}:

stdenv.mkDerivation rec {
  pname = "prettier-ada";
  version = "25.0.0";

  src = fetchFromGitHub {
    name = "prettier-ada";
    owner = "furioncycle";
    repo = "prettier-ada";
    rev = "c127607d00934d28428694b80e7fc1709397aa2b";
    sha256 = "YzJ8H+TOUQn5fOGQQW4yRODB72T7UGSLyb+fnuxUZW8=";
  };

  makeFlags = [
    "LIBRARY_TYPE=static"
    "PREFIX=${placeholder "out" }"
    "BUILD_MODE=prod"
  ];

  nativeBuildInputs = [
    gnat
    gprbuild
    gnatcoll-core
    vss
  ];

}
