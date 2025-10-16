`timescale 1ns / 1ps
`include "alu.v"


module alu_tb;
reg [15:0] a, b;
reg [2:0] alu_sel;
wire [15:0] result;
wire zero_flag;

  alu alu_t(
            .a(a), 
            .b(b), 
            .alu_sel(alu_sel), 
            .result(result), 
            .zero_flag(zero_flag)
           );
  
 initial begin
    $dumpfile("alu.vcd");
    $dumpvars(0,alu_tb);

    a = 16'd10; 
    b = 16'd5;
    alu_sel = 3'd0;  //opcode for addition

    #10;

    a = 16'd15;
    b = 16'd8;
    alu_sel = 3'd1; //opcode for subtraction

    #10;

    a = 16'd0;
    alu_sel = 3'd2; //opcode for not operation on operand a

    #10;

    a = 16'd45;
    b = 16'd45;
    alu_sel = 3'd6; //opcode for OR operation between a and b

    #10;

    a = 16'd30;
    b = 16'd15;
    alu_sel = 3'd5; //opcode for AND operation between a and b

    #10;

    a = 16'd100;
    b = 16'd200;
    alu_sel = 16'd7; //compares a and b

    #10;

    a = 16'd256;
    b = 16'd2;
    alu_sel = 3'd3; //left shift operation on a by b times

    #10;

    a = 16'd64;
    b = 16'd3;
    alu_sel = 3'd4; //reght shift operation on a by b times

    #40;

    $finish;
  end
endmodule

