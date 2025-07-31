# 16-bit RISC Processor (Verilog)

This repository contains the RTL design of a custom-built **16-bit RISC Processor** written in **Verilog**. The processor follows a modular design approach and includes essential components like the ALU, Register File, Control Unit, Instruction and Data Memory, and an integrated Datapath. The design is fully synthesizable and verified through individual module-level testbenches.

---

## 📜 Instruction Set Format

Each instruction is 16 bits wide. The processor supports multiple instruction formats:

- **R-Type**:  
  `4 bits opcode | 3 bits operand1 | 3 bits operand2 | 3 bits destination | offset`  
  Used for arithmetic and logic operations.

- **J-Type**:  
  `4 bits opcode | 12 bits offset`  
  Used for jump instructions.

- **B-Type**:  
  Used for **branch** instructions (e.g., BEQ, BNE).

- **S-Type**:  
  Used for **store** instructions.

---

## 📁 Project Structure

16-bit-risc-processor/
├── design_modules/ # All individual Verilog design files
├── testbenches.v # Contains all testbenches in a single file
├── rough_sketch.png # Block diagram of the processor (optional)
├── README.md # This file


---

## ⚙️ Modules Included

The processor consists of the following key modules:

- `alu`           – Performs arithmetic, logic, and shift operations.  
- `reg_file`      – Register file with read and write access.  
- `instruction_mem` – Supplies instructions based on program counter (PC).  
- `data_memory`   – Handles memory read/write operations.  
- `alu_control`   – Decodes ALU control signals based on instruction.  
- `cu`            – Control unit to generate all required control signals.  
- `data_path`     – integration of all above modules.
- `risc_processor` - Top level module connecting data path and control unit to form requried risc processor.
---

## 🧪 Testbenches

All module-level testbenches are included in a single file:  
**`testbenches.v`**

- Each testbench uses `$dumpfile()` and `$dumpvars()` for waveform generation.
- You can simulate each testbench independently.

---

## 🔧 How to Compile and Simulate (Icarus Verilog Example)

> Make sure you have **Icarus Verilog** and **GTKWave** installed.

### ✅ Method 1: Copy Module + Testbench into Single File

1. Create a file: `alu_tb.v`
2. Copy the `alu` module from `alu.v` into `alu_tb.v`
3. Copy the corresponding testbench from `testbenches.v` into `alu_tb.v`

### ✅ Method 2: Use Include Directives

`include "alu.v" in testbench.v

▶️ Compile and Simulate

1. Open terminal
2. iverilog -o alu_tb alu_tb.v     # Compile
vvp alu_tb                      # Run simulation
gtkwave alu_tb.vcd             # (Optional) View waveforms
3. Ensure the testbench contains:
   initial begin
  $dumpfile("alu_tb.vcd");
  $dumpvars(0, <testbench_module_name>);
   end


⭐ Features

1. 16-bit data path with word-aligned instructions
2. Modular, easy-to-read Verilog code
3. Supports: arithmetic, logic, memory, branch, and jump instructions
4. Easy simulation and waveform viewing


🚀 Future Improvements

1. Add pipelining stages: IF, ID, EX, MEM, WB
2. Extend instruction set with more opcodes
3. Add forwarding and hazard detection logic
4. Full integration testbench with instruction sequencing


