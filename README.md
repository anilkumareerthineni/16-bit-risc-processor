# 16-bit RISC Processor in Verilog HDL

This repository contains the **Verilog HDL implementation of a 16-bit RISC processor**.  
The processor supports arithmetic, logical, memory, and control operations with a modular design approach.

> **Tip:** For a detailed explanation of design, simulation, and results, please go through the full project report included in this repository.

---

## Features

- 16-bit RISC processor with a reduced instruction set  
- Supports arithmetic & logic: ADD, SUB, AND, OR, NOT, SHIFT, COMPARE  
- Memory operations: LOAD, STORE  
- Control instructions: JMP, BEQ, BNQ  
- Modular design: ALU, ALU Control, Control Unit, Register File, Instruction & Data Memory, CPU Top Module  
- RTL-level design verified using Icarus Verilog and GTKWave  
- Synthesizable using Yosys for FPGA implementation

---

## Repository Structure

├── alu.v # Arithmetic Logic Unit
├── alu_control.v # ALU control logic
├── control_unit.v # Control unit
├── register_file.v # General-purpose registers
├── instruction_memory.v # Program instructions
├── data_memory.v # Data memory
├── risc_processor.v # CPU top module integrating all components
├── testbenches/ # Testbench files for individual modules
├── report.pdf # Full project report (highly recommended)
└── README.md

---

## Getting Started

### Simulation

1. Compile Verilog modules and testbench using Icarus Verilog:

```bash
iverilog -o example.vvp design_example.v design_testbench.v
vvp example.vvp
gtkwave example.vcd
```

2. Synthesis 

Synthesize design using Yosys:

yosys
read_verilog alu.v alu_control.v control_unit.v register_file.v instruction_memory.v data_memory.v cpu_top.v
hierarchy -top cpu_top
flatten cpu_top
show -format png -prefix cpu_top cpu_top


Explore the generated netlist and module hierarchy.
Refer to the full report for a step-by-step synthesis guide and waveform examples.


## Future Work

- Add pipelining to improve performance

- Integrate UART for I/O communication

- Expand instruction memory for larger programs


## Tools Used

- Icarus Verilog – Simulation

- GTKWave – Waveform visualization

- Yosys – RTL synthesis

- VS Code – HDL editing


## License

This project is for educational purposes. Please give credit if used or referenced.


For complete design details, simulation results, and architecture diagrams, go through the project report included in this repository.
