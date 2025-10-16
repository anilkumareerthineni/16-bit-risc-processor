`timescale 1ns / 1ps
`include "instruction_mem.v"

module instruction_mem_tb;
  reg [15:0] pc;
  wire [15:0] instr_out;

  instruction_mem instr_mem1(
                             .pc(pc),
                             .instr_out(instr_out)
                            );

  initial begin
    $dumpfile("instruction_mem.vcd");
    $dumpvars(0,instruction_mem_tb);

    pc = 16'd8;

    #5;

    pc = 16'd30;

    #5;

    pc = 16'd57;

    #5;

    pc = 16'd158;

    #30;
  end
endmodule