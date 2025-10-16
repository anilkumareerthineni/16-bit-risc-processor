`timescale 1ns / 1ps
`include "control_unit.v"

module control_unit_tb;
  reg [3:0] opcode;
  wire [1:0] alu_op;
  wire jump, beq, bne, mem_read, mem_write, 
       alu_src, reg_dst, mem_to_reg, reg_write;
  
  control_unit cu1(
                   .opcode(opcode),
                   .alu_op(alu_op),
                   .jump(jump),
                   .beq(beq),
                   .bne(bne),
                   .mem_read(mem_read),
                   .mem_write(mem_write),
                   .alu_src(alu_src),
                   .reg_dst(reg_dst),
                   .mem_to_reg(mem_to_reg),
                   .reg_write(reg_write)
  );

  initial begin
    $dumpfile("control_unit.vcd");
    $dumpvars(0,control_unit_tb);

    opcode = 4'd0;

    #5;

    opcode = 4'd1;

    #5;

    opcode = 4'd2;

    #5;

    opcode = 4'd3;

    #5;

    opcode = 4'd4;

    #5;

    opcode = 4'd5;

    #5;

    opcode = 4'd7;

    #5;

    opcode = 4'd9;

    #5;

    opcode = 4'd10;

    #5;

    opcode = 4'd12;

    #5;

    opcode = 4'd13;

    #5;

    opcode = 4'd14;

    #5;

    opcode = 4'd15;

    #40;

    $finish;
  end
endmodule
