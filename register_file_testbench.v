`timescale 1ns/1ps
`include "register_file.v"

module register_file_tb;
  reg clk, write_en;
  reg [2:0] read_addr1, read_addr2, write_addr;
  reg [15:0] write_data;
  wire [15:0] read_data1, read_data2;

  reg_file regfile1(
                    .clk(clk),
                    .write_en(write_en),
                    .read_addr1(read_addr1),
                    .read_addr2(read_addr2),
                    .write_addr(write_addr),
                    .write_data(write_data),
                    .read_data1(read_data1),
                    .read_data2(read_data2)
                    );

  always begin
    #10;
    clk = ~clk;
  end
  initial begin
    $dumpfile("register_file.vcd");
    $dumpvars(0,register_file_tb);

    clk = 1'b0;

    write_en = 1'b1;
    write_addr = 3'd3;
    write_data = 16'd35;
    read_addr1 = 3'd2;
    read_addr2 = 3'd3;


    #25;
    write_addr = 3'd4;
    write_data = 16'd47;
    read_addr1 = 3'd4;
    read_addr2 = 3'd5;

    #25;
    write_addr = 3'd5;
    write_data = 16'd256;
    read_addr1 = 3'd6;
    read_addr2 = 3'd7;

    #40;
    $finish;
  end
endmodule
 