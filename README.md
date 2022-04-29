Hardware Playground
===

Contains [FuseSoC](https://fusesoc.readthedocs.io/en/stable/index.html) cores as I work through the [Learning FPGSs](https://www.amazon.com/Learning-FPGAs-Digital-Design-Beginners/dp/1491965495) book.

Each project is a separate core, buildable for both the Alchitry Cu and the Alchitry Au+.  For the Cu, the core is built with IceStore and can be built using `fusesoc run --target=cu watersofoblivion:hdub:<core-name>`.  For the Au+, the core is built with Xilinx Vivado and can be built using `fusesoc run --target=au_plus --setup --build watersofoblivion:hdub:<core-name>`.  For both, the cores must be loaded onto the devices using the Alchitry Loader (part of [Alchitry Labs](https://alchitry.com/alchitry-labs).)

Available Cores:

* `fpga-book-first`: Turn on a LED when the button is pressed.
