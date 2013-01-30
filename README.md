<img src="https://raw.github.com/Ductapemaster/flexSD/master/img/flexSD_logo_tagline.png" width="240" height="102">

Open source, flexible signal processing platform based on sigma delta processing techniques

This repo contains all of the code for the platform's FPGA.

## About ##
Control Systems are becoming ubiquitous. Common examples include thermostats, ABS brakes, manufacturing processes, robots, and autopilot systems. Unfortunately, the tools to develop these systems are slow, have high power requirements, and are cost-prohibitive for educational and research use. Currently, it is common practice for dynamical system control to be taught using the Simulink® simulation and design suite running on a PC, and an external hardware interface is used to communicate with the devices under control. 

The goal of FlexSD is to provide a high speed, low power, and low cost platform for control and signal processing experiments. The control algorithms are performed on a field programmable gate array (FPGA) that is interfaced to an ARM processor. By using an FPGA as a controller, high speeds are possible because the FPGA is clocked significantly faster than the incoming data stream. The ARM processor can reprogram the FPGA’s memory mapped filters and log data off of running experiments without modifying the loaded bitstream. This framework is advantageous as it can be configured without requiring time-intensive logic synthesis for every experiment revision. A MATLAB®/Simulink® interface will be provided that would allow a user to write control algorithms in Simulink® and port them to the device. 

One of the novel aspects of this project is that the FPGA hosts a custom made filter framework that processes a 1 bit, sigma delta encoded stream from the analog to digital converter (ADC). This allows a large number of filters to be synthesized on the FPGA and also decreases the routing cost between the filters in the design. 

The project will be completely open source. All the code and printed circuit board files will be posted online to make it easy for other universities, companies, and hobbyists to experiment using the platform. The ARM processor and FPGA reside on a single board computer (SBC) that can be inexpensively obtained from Technologic Systems®

## Branches ##

- [Master](https://github.com/flexSD/flexSD): Merged latest branch into master, now the working branch
- [controls_board](https://github.com/flexSD/flexSD/tree/controls_board): Contains some code for testing on-board peripherals (LEDs and such I believe)
- [dac_spi_included](https://github.com/flexSD/flexSD/tree/dac_spi_included): Initial testing of the DAC's SPI module in the code
- [adc_input](https://github.com/flexSD/flexSD/tree/adc_input): Initial testing of the ADC's inputs
- [latest](https://github.com/flexSD/flexSD/tree/latest): All changes up until the end of Spring 2012, merged into master
