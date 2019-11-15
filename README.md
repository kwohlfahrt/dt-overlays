# Linux DT Overlays

Device-tree overlays extracted from the Raspberry Pi kernel, and ported to the
mainline Linux kernel where necessary.

Compatible base device trees must be built with symbols enabled (`-@`). This
is because path references (`&{/soc/foo@0}`) cannot be used in overlays.
