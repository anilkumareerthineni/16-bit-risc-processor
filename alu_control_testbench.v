`timescale 1ns / 1ps
`include "alu_control.v"

module alu_control_tb;
  reg [1:0] ALU_op;
  reg [3:0] opcode;
  wire [2:0] ALU_cnt;

  alu_control alu_cnt1(
                       .ALU_op(ALU_op),
                       .opcode(opcode),
                       .ALU_cnt(ALU_cnt)
                       );

  initial begin
    $dumpfile("alu_control.vcd");
    $dumpvars(0,alu_control_tb);

    ALU_op = 2'b10; // ALU_cnt will be  0 irrespective of opcode
    opcode = 4'd1;
    #5;
    opcode = 4'd5;
    #5;
    opcode = 4'd8;

    #10;

    ALU_op = 2'b01; //ALU_cnt will be 1 irrespective of opcode
    opcode = 4'd1;
    #5;
    opcode = 4'd2;
    #5;
    opcode = 4'd5;

    #10;

    ALU_op = 2'b00; //ALU_op depend on opcode 
    opcode = 4'd3;
    #10;
    opcode = 4'd4;
    #10;
    opcode = 4'd6;
    #10;
    opcode = 4'd12; // if opcode greater than 9 ALU_cnt will be 0 by default

    ALU_op = 2'b11; // ALU_op = 3 is not used. but ALU_cnt will be 0 by default
    opcode = 4'd6;

    #40;

    $finish;
  end
endmodule