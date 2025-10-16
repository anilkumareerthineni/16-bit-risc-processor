`timescale 1ns / 1ps
`include "data_memory.v"

module data_memory_tb;
  reg clk, write_en, read_en;
  reg [15:0] access_addr, write_data;
  wire [15:0] read_data;

  data_memory data1(
                    .clk(clk),
                    .write_en(write_en),
                    .read_en(read_en),
                    .access_addr(access_addr),
                    .write_data(write_data),
                    .read_data(read_data)
                   );

  always begin
    #10 clk = ~clk;
  end

  initial begin
    $dumpfile("data_memory.vcd");
    $dumpvars(0,data_memory_tb);

    clk = 1'b0;
    write_en = 1'b0;
    read_en = 1'b0;
    access_addr = 16'd0;
    write_data = 16'd0;
    

    #8;
    write_en = 1'b1;
    access_addr = 16'd5;
    write_data = 16'd50;

    #16;
    write_en = 1'b0;
    read_en = 1'b1; //check whether written data is correct

    #20
    write_en = 1'b1; //check what happens when both read and write controls enables
    access_addr = 16'd2;
    #10;
    write_en = 1'b0;
    read_en = 1'b0;

    #40;
    $finish;
  end
endmodule