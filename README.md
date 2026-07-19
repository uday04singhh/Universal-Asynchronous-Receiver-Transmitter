# UART (Universal Asynchronous Receiver-Transmitter)

A SystemVerilog implementation of a UART transmitter and receiver with selectable baud rates.

## Overview
- Configurable baud rate support
- Standard start/stop bit framing
- Verified transmit and receive functionality using a SystemVerilog testbench

## Tech Stack
- **Language:** SystemVerilog
- **Verification:** SystemVerilog testbench (simulation-based)

## Files
- `Source/` — UART transmitter/receiver RTL, UART Top, Baud rate generator
- `Testbench/` — SystemVerilog testbench


## Status
Core transmit/receive functionality verified. 
Planned: constrained-random stimulus and functional coverage to strengthen verification.

## Author
Uday Singh — BE Electronics and Computer Engineering, Thapar Institute of Engineering and Technology
