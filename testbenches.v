`timescale 1ns / 1ps

module alu_tb;

  // Inputs
  reg [15:0] a, b;
  reg [2:0] alu_sel;

  // Outputs
  wire [15:0] result;
  wire zero_flag;

  // Instantiate the ALU
  alu uut (
    .a(a),
    .b(b),
    .alu_sel(alu_sel),
    .result(result),
    .zero_flag(zero_flag)
  );

  // Test sequence
  initial begin
    // Dump for GTKWave
    $dumpfile("alu_tb.vcd");
    $dumpvars(0, alu_tb);

    // Test Add
    a = 16'd5; b = 16'd10; alu_sel = 3'd0; #10;
    $display("ADD: a=%d, b=%d, result=%d, zero_flag=%b", a, b, result, zero_flag);

    // Test Sub
    a = 16'd20; b = 16'd5; alu_sel = 3'd1; #10;
    $display("SUB: a=%d, b=%d, result=%d, zero_flag=%b", a, b, result, zero_flag);

    // Test NOT
    a = 16'hFFFF; b = 16'd0; alu_sel = 3'd2; #10;
    $display("NOT: a=%h, result=%h, zero_flag=%b", a, result, zero_flag);

    // Test Left Shift
    a = 16'd2; b = 16'd2; alu_sel = 3'd3; #10;
    $display("LSHIFT: a=%d, b=%d, result=%d, zero_flag=%b", a, b, result, zero_flag);

    // Test Right Shift
    a = 16'd16; b = 16'd2; alu_sel = 3'd4; #10;
    $display("RSHIFT: a=%d, b=%d, result=%d, zero_flag=%b", a, b, result, zero_flag);

    // Test AND
    a = 16'b1100; b = 16'b1010; alu_sel = 3'd5; #10;
    $display("AND: a=%b, b=%b, result=%b, zero_flag=%b", a, b, result, zero_flag);

    // Test OR
    a = 16'b1100; b = 16'b1010; alu_sel = 3'd6; #10;
    $display("OR: a=%b, b=%b, result=%b, zero_flag=%b", a, b, result, zero_flag);

    // Test Compare (a < b)
    a = 16'd5; b = 16'd10; alu_sel = 3'd7; #10;
    $display("CMP: a=%d, b=%d, result=%d, zero_flag=%b", a, b, result, zero_flag);

    // Test Compare (a >= b)
    a = 16'd20; b = 16'd10; alu_sel = 3'd7; #10;
    $display("CMP: a=%d, b=%d, result=%d, zero_flag=%b", a, b, result, zero_flag);

    // End of simulation
    $finish;
  end

endmodule



module control_unit_tb;

  // Inputs
  reg [3:0] opcode;

  // Outputs
  wire [1:0] alu_op;
  wire jump, beq, bne, mem_read, mem_write, alu_src, reg_dst, mem_to_reg, reg_write;

  // Instantiate the Unit Under Test (UUT)
  control_unit uut (
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
    $dumpfile("control_unit_tb.vcd");
    $dumpvars(0, control_unit_tb);

    // Apply all opcode values 0 to 12
    for (integer i = 0; i <= 12; i = i + 1) begin
      opcode = i[3:0];
      #10;
    end

    // Test invalid opcode
    opcode = 4'd15;
    #10;

    $finish;
  end

endmodule



module data_path_tb;

  // Inputs
  reg clk;
  reg jumps, beq, mem_read, mem_write, alu_src, reg_dst, mem_to_reg, reg_write, bne;
  reg [1:0] alu_op;

  // Outputs
  wire [3:0] opcode;

  // Instantiate the Unit Under Test (UUT)
  data_path uut (
    .clk(clk),
    .jumps(jumps),
    .beq(beq),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .alu_src(alu_src),
    .reg_dst(reg_dst),
    .mem_to_reg(mem_to_reg),
    .reg_write(reg_write),
    .bne(bne),
    .alu_op(alu_op),
    .opcode(opcode)
  );

  // Clock generation: 10ns period
  always #5 clk = ~clk;

  initial begin
    // Setup VCD dumping
    $dumpfile("data_path_tb.vcd");
    $dumpvars(0, data_path_tb);

    // Initialize Inputs
    clk = 0;
    jumps = 0;
    beq = 0;
    mem_read = 0;
    mem_write = 0;
    alu_src = 0;
    reg_dst = 0;
    mem_to_reg = 0;
    reg_write = 0;
    bne = 0;
    alu_op = 2'b00;

    // Wait for reset
    #10;

    // Test ALU operation (e.g., ADD)
    alu_op = 2'b10;
    reg_write = 1;
    reg_dst = 1;
    alu_src = 0;
    #10;

    // Test ALU with immediate value
    alu_src = 1;
    #10;

    // Test memory write
    mem_write = 1;
    alu_src = 0;
    #10;

    // Test memory read
    mem_write = 0;
    mem_read = 1;
    mem_to_reg = 1;
    reg_write = 1;
    #10;

    // Test jump
    jumps = 1;
    #10;

    // Test BEQ
    jumps = 0;
    beq = 1;
    #10;

    // Test BNE
    beq = 0;
    bne = 1;
    #10;

    // End simulation
    $finish;
  end

endmodule
