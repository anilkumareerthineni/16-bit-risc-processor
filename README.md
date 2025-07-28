16-bit RISC Processor (Verilog)

This repository contains the RTL design of a custom-built 16-bit RISC Processor written in Verilog. The processor is built with modular design principles and includes components such as the ALU, Register File, Control Unit, Memory units, and a complete Datapath integration. The design is synthesizable and testable via module-level testbenches.

Instruction Set:
16 bit istruction
R-Type -- 4bits opcode , 3 bit operand address, 3 bit operand address, 3 bit destination address and remaining bits are offset
J-Type -- 4 bits opcode and remaining offset
B-Type -- Branch Instruction
S-Type -- Store Instruction


 Project Structure:
16-bit-risc-processor/
rough sketch of risc processor
All design modules + testbenches
README.md (This file)

Modules Included:
The processor is implemented as a collection of the following key modules:

 `alu`          Performs arithmetic, logic, shift operations. 
 `reg_file`     register bank with read/write access. 
 `instruction_mem` Provides instruction based on PC. 
 `data_memory`   Stores data for memory operations. 
 `alu_control`   Decodes ALU operations from instruction and control signals. 
 `data_path`     Connects all modules to perform complete instruction cycle. 
 `cu`            Control unit which decodes instruction and extracts control signals 


 Testbenches:

All testbenches are included in a single Verilog file:  
`testbenches.v`

Each testbench:
Uses `$dumpfile()` and `$dumpvars()` for waveform generation
runs independently 


How to Compile and Simulate:

You can extract any module and its testbench from `testbenches.v` into a single verilog file and run them 

Example: ALU Testbench (with Icarus Verilog)

1. Create a file `alu_tb.v` containing:
   copy the module alu from alu.v and paste it into alu_tb.v
   copy testbench for alu from testbenches.v and paste it into alu_tb.v

2. Compile using Icarus Verilog:
   sure you have icarus verilog compiler in your pc installed
   go to terminal and write commands as below
     Compile the code:
      iverilog -o alu_tb alu_tb.v
     Run the simulation:
   vvp alu_tb
   
   View waveforms (Optional):
     gtkwave alu_tb.vcd
   
Make sure the testbench includes:
  verilog module instance of respective design
  "$dumpfile("alu_tb.vcd");" and "$dumpvars(0, <testbench_module_name>);"  in initial block in testbench

Features:
  16-bit data path with word-aligned instructions
  Modular and scalable design
  BEQ, BNE, JUMP, memory and ALU operations supported
  Easy-to-use simulation and waveform generation

Future Improvements:
  Add pipelining stages (IF, ID, EX, MEM, WB)
  Add support for more instruction types
  Include hazard detection and forwarding unit
