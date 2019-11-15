{ linux, stdenvNoCC, dtc, callPackage }:

let
  linux-dtbs = callPackage ./linux-dtbs.nix {};
in stdenvNoCC.mkDerivation {
  name = "dt-overlays";
  version = "0.1.0";
  src = ./src;

  nativeBuildInputs = [ dtc ];

  buildPhase = ''
    dtc -@ -I dts -O dtb ./w1-gpio.dts > ./w1-gpio.dtbo
  '';

  installPhase = ''
    mkdir $out
    cp ./*.dtbo $out
  '';

  doCheck = true;
  checkInputs = [ dtc ];
  checkPhase = ''
    fdtoverlay -v -o test.dtb -i ${linux-dtbs}/dtbs/broadcom/bcm2837-rpi-3-b-plus.dtb ./w1-gpio.dtbo
    # fdtoverlay exits with 0 even if it fails, so check for output
    ls -l test.dtb
  '';
}
