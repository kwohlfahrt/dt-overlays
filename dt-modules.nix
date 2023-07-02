{ linux, stdenv, callPackage, pahole }:

stdenv.mkDerivation {
  name = "dt-modules";
  version = "0.1.0";
  src = ./src;

  nativeBuildInputs = [ pahole ];

  buildPhase = ''
    make modules KDIR=${linux.dev}/lib/modules/${linux.modDirVersion}/build
  '';

  installPhase = ''
    mkdir $out
    MODDIR=$out/lib/modules/${linux.modDirVersion}/extra
    mkdir -p $MODDIR
    cp ./*.ko $MODDIR
  '';

  doCheck = false;
}
