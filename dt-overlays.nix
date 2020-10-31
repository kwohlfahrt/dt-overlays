{ linux, stdenv, dtc }:

stdenv.mkDerivation {
  name = "dt-overlays";
  version = "0.1.0";
  src = ./src;

  nativeBuildInputs = [ dtc ];

  buildPhase = ''
    make dtbos KDIR=${linux.dev}/lib/modules/${linux.modDirVersion}/build
  '';

  installPhase = ''
    mkdir $out
    cp ./*.dtbo $out
  '';
}
