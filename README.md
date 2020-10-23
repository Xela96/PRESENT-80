# PRESENT-80
Masters Project

## Project Overview
The PRESENT family of lightweight block ciphers were designed to provide a solution for the use of block ciphers in constrained environments, such as RFID tags and sensors. The
area of IoT is an industry which will benefit greatly from lightweight cryptography, allowing for secure communication and storage of data. The PRESENT cipher allows for implementations using either an 80 or 128-bit key. This project focuses on the 80-bit key implementation of the cipher. Two designs of the cipher will be designed in VHDL, one with a focus on area constraints and the other on performance. An implementation is integrated as an AXI peripheral to achieve hardware acceleration of the cipher.

## Simulating These Designs
To simulate the VHDL implementations of these designs, an IDE such as Vivado is required. 
The round-based and pipelined core can both be simulated separately. The files in the *sim* and *sources* folders are required to simulate the design.
Once these files have been added to the project, the core testbench file should be set as the top file.
The simulation can now be run for the design
