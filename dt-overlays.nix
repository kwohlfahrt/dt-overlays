{ linux, linuxDtbsFor, stdenvNoCC, dtc, callPackage }:

let
  linux-dtbs = linuxDtbsFor linux { filter = "bcm*-rpi-*.dtb"; };
in stdenvNoCC.mkDerivation {
  name = "dt-overlays";
  version = "0.1.0";
  src = ./src;

  nativeBuildInputs = [ dtc ];

  buildPhase = ''
    for dts in $(find . -type f); do
      dtc -@ -I dts -O dtb $dts > $(basename $dts .dts).dtbo
    done
  '';

  installPhase = ''
    mkdir $out
    cp ./*.dtbo $out
  '';

  doCheck = true;
  checkInputs = [ dtc ];
  checkPhase = ''
    for overlay in $(find . -type f -name "*.dtbo"); do
      for base in $(find ${linux-dtbs} -type f); do
        echo Testing $(basename $overlay) onto $(basename $base)
        # fdtoverlay exits with 0 even if it fails, so check for output
        rm -f test.dtb
        fdtoverlay -o test.dtb -i $base $overlay
        ls -l test.dtb > /dev/null
      done
    done
  '';
}
