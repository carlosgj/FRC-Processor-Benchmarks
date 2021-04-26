# FRC-Processor-Benchmarks
A set of benchmarks for FRC processors

This code is adapted from [Roy Longbottom's Raspberry Pi benchmarks](http://www.roylongbottom.org.uk/Raspberry%20Pi%20Benchmarks.htm). 

Run `make` to build the individual scripts. So far, Whetstone, Dhrystone 2, and LINPACK are included. For Whetstone and Dhrystone, the scripts will execute two scenarios: singlethreaded, and one-thread-per-core. 
The makefile will attempt to figure out your architecture. Currently, only `arm-linux-gnueabihf` (Pi) and `aarch64-linux-gnu` (Jetson) are handled.
If this is a Pi, a NEON-enabled version of LINPACK will also be built. 

Please note that these scripts don't do anything to optimize the board itself. So if anything needs to be done to maximize the performance of the board (`jetson_clocks` etc.), please do so manually before running the benchmarks. 

Run `make run` to run all of the benchmarks. The results will be in text files placed in the `results` subdirectory.
