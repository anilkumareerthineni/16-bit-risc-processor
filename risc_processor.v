module instruction_mem (input [15:0] pc, output [15:0] instr_out);

reg [15:0] memory [0:15];

wire [3:0] addr = pc[4:1];

assign instr_out = memory[addr];

initial begin  //initialize instruction memory with some random values
    for(integer i = 0 : i < 16 : i = i + 1) begin
        memory[i] = $random(i);
    end
end

endmodule

//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

module reg_file (input clk, input write_en, input [2:0] read_addr1, input [2:0] read_addr2, input [2:0] write_addr, input [15:0] write_data, output [15:0] read_data1, output [15:0] read_data2);

reg [15:0] reg_mem [0:7];

assign read_data1 = reg_mem[read_addr1];
assign read_data2 = reg_mem[read_addr2];

initial begin
  for(integer i = 0; i < 8; i = i + 1) begin
    reg_mem[i] <= 16'd0;
  end
end

always @(posedge clk) begin //write to registers only at clock edges
  if(write_en) begin 
    reg_mem[write_addr] <= write_data;
  end
end
endmodule

//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

module data_memory (input clk, input write_en, input read_en, input [15:0] access_addr, input [15:0] write_data, output [15:0] read_data);

reg [15:0] memory [0:7];

wire [2:0] addr = access_addr[2:0];
initial begin
   for(integer j = 0 : j < 8 : j = j + 1) begin
    memory[j] = $random(j);
   end
end

always @(posedge clk) begin //write to data memory at clock edges 
    if(write_en) begin
        memory[addr] <= write_data;
    end
end

assign read_data = (read_en == 1'b1) ? memory[addr] : 16'd0;

endmodule

//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

module alu (input [15:0] a, input [15:0] b, input [2:0] alu_sel, output reg [15:0] result, output zero_flag);

parameter Add = 3'd0;
parameter Sub = 3'd1;
parameter Not = 3'd2;
parameter Or = 3'd6;
parameter And = 3'd5;
parameter Compare = 3'd7;
parameter Le_shift = 3'd3;
parameter Ri_shift = 3'd4;

always @(*) begin
  
    case(alu_sel)
    Add : result = a + b;
    Sub : result = a - b;
    Not : result = ~a;
    Or : result = a | b;
    And : result = a & b;
    Compare : result = (a < b) ? 8'd1 : 8'd0;
    Le_shift : result = a << b;
    Ri_shift : result = a >> b;
    default : result = a + b;
    endcase

end

assign zero_flag = (result == 8'd0) ? 1'b1 : 1'b0;

endmodule

//---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

module alu_control(input [1:0] ALU_op, input [3:0] opcode, output reg [2:0] ALU_cnt);

wire [5:0] alucontrolin = {ALU_op, opcode};

always @(alucontrolin) begin
    casex(alucontrolin)
    6'b10xxxx :  ALU_cnt = 3'd0;
    6'b01xxxx : ALU_cnt = 3'd1;
    6'b000010 : ALU_cnt = 3'd0;
    6'b000011 : ALU_cnt = 3'd1;
    6'b000100 : ALU_cnt = 3'd2;
    6'b000101 : ALU_cnt = 3'd3;
    6'b000110 : ALU_cnt = 3'd4;
    6'b000111 : ALU_cnt = 3'd5;
    6'b001000 : ALU_cnt = 3'd6;
    6'b001001 : ALU_cnt = 3'd7;
    default : ALU_cnt = 3'd0;
    endcase
end

endmodule

//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

module control_unit(input [3:0] opcode, output reg [1:0] alu_op, output reg jump, beq, bne, mem_read, mem_write, alu_src, reg_dst, mem_to_reg, reg_write);

always @(*) begin
    case(opcode) 

    4'd0 : begin // load to reg
        reg_dst = 1'b0;
        alu_src = 1'b1;
        mem_to_reg = 1'b1;
        reg_write = 1'b1;
        mem_read = 1'b1;
        mem_write = 1'b0;
        beq = 1'b0;
        bne = 1'b0;
        alu_op = 2'b10;
        jump = 1'b0;
    end

    4'd1 : begin // store to mem
        reg_dst = 1'b0;
        alu_src = 1'b1;
        mem_to_reg = 1'b0;
        reg_write = 1'b0;
        mem_read = 1'b0;
        mem_write = 1'b1;
        beq = 1'b0;
        bne = 1'b0;
        alu_op = 2'b10;
        jump = 1'b0;
    end

    4'd2 : begin
        reg_dst = 1'b1;
        alu_src = 1'b0;
        mem_to_reg = 1'b0;
        reg_write = 1'b1;
        mem_read = 1'b0;
        mem_write = 1'b0;
        beq = 1'b0;
        bne = 1'b0;
        alu_op = 2'b00;
        jump = 1'b0;
    end

    4'd3 : begin
        reg_dst = 1'b1;
        alu_src = 1'b0;
        mem_to_reg = 1'b0;
        reg_write = 1'b1;
        mem_read = 1'b0;
        mem_write = 1'b0;
        beq = 1'b0;
        bne = 1'b0;
        alu_op = 2'b00;
        jump = 1'b0;
    end

    4'd4 : begin
        reg_dst = 1'b1;
        alu_src = 1'b0;
        mem_to_reg = 1'b0;
        reg_write = 1'b1;
        mem_read = 1'b0;
        mem_write = 1'b0;
        beq = 1'b0;
        bne = 1'b0;
        alu_op = 2'b00;
        jump = 1'b0;
    end

    4'd5 : begin
        reg_dst = 1'b1;
        alu_src = 1'b0;
        mem_to_reg = 1'b0;
        reg_write = 1'b1;
        mem_read = 1'b0;
        mem_write = 1'b0;
        beq = 1'b0;
        bne = 1'b0;
        alu_op = 2'b00;
        jump = 1'b0;
    end

    4'd6 : begin
        reg_dst = 1'b1;
        alu_src = 1'b0;
        mem_to_reg = 1'b0;
        reg_write = 1'b1;
        mem_read = 1'b0;
        mem_write = 1'b0;
        beq = 1'b0;
        bne = 1'b0;
        alu_op = 2'b00;
        jump = 1'b0;
    end

    4'd7 : begin
        reg_dst = 1'b1;
        alu_src = 1'b0;
        mem_to_reg = 1'b0;
        reg_write = 1'b1;
        mem_read = 1'b0;
        mem_write = 1'b0;
        beq = 1'b0;
        bne = 1'b0;
        alu_op = 2'b00;
        jump = 1'b0;
    end

    4'd8 : begin
        reg_dst = 1'b1;
        alu_src = 1'b0;
        mem_to_reg = 1'b0;
        reg_write = 1'b1;
        mem_read = 1'b0;
        mem_write = 1'b0;
        beq = 1'b0;
        bne = 1'b0;
        alu_op = 2'b00;
        jump = 1'b0;
    end

    4'd9 : begin
        reg_dst = 1'b1;
        alu_src = 1'b0;
        mem_to_reg = 1'b0;
        reg_write = 1'b1;
        mem_read = 1'b0;
        mem_write = 1'b0;
        beq = 1'b0;
        bne = 1'b0;
        alu_op = 2'b00;
        jump = 1'b0;
    end

    4'd10 : begin // BRANCH
        reg_dst = 1'b0;
        alu_src = 1'b0;
        mem_to_reg = 1'b0;
        reg_write = 1'b1;
        mem_read = 1'b0;
        mem_write = 1'b0;
        beq = 1'b1;
        bne = 1'b0;
        alu_op = 2'b00;
        jump = 1'b0;
    end

    4'd11 : begin
        reg_dst = 1'b0;
        alu_src = 1'b0;
        mem_to_reg = 1'b0;
        reg_write = 1'b1;
        mem_read = 1'b0;
        mem_write = 1'b0;
        beq = 1'b0;
        bne = 1'b1;
        alu_op = 2'b00;
        jump = 1'b0;
    end

    4'd12 : begin
        reg_dst = 1'b0;
        alu_src = 1'b0;
        mem_to_reg = 1'b0;
        reg_write = 1'b1;
        mem_read = 1'b0;
        mem_write = 1'b0;
        beq = 1'b0;
        bne = 1'b0;
        alu_op = 2'b00;
        jump = 1'b1;
    end

    default : begin
        reg_dst = 1'b1;
        alu_src = 1'b0;
        mem_to_reg = 1'b0;
        reg_write = 1'b1;
        mem_read = 1'b0;
        mem_write = 1'b0;
        beq = 1'b0;
        bne = 1'b0;
        alu_op = 2'b00;
        jump = 1'b0;
    end
    endcase
end

endmodule

//------------------------------------------------------------------------------------------------------------------------------------------------------------

module data_path (input clk, 
input jump, beq, mem_read, mem_write, alu_src, reg_dst, mem_to_reg, reg_write, bne,
input [1:0] alu_op, output [3:0] opcode);

reg [15:0] pc_cur;
wire [15:0] pc_next,pc2;
wire [15:0] instr;
wire [2:0] reg_write_dest;
wire [15:0] reg_write_data;
wire [2:0] reg_read_addr1;
wire [15:0] reg_read_data1;
wire [2:0] reg_read_addr2;
wire [15:0] reg_read_data2;
wire [15:0] ext_im, read_data2;
wire [2:0] ALU_control;
wire [15:0] ALU_out;
wire zer0_falg;
wire [15:0] pc_j, pc_beq, pc_2beq, pc_2bne, pc_bne;
wire beq_control, zero_flag;
wire [12:0] jump_shift;
wire [15:0] mem_read_data;

always @(posedge clk) begin
  pc_cur <= pc_next;
end

initial begin
    pc_cur <= 16'd0;
end

assign pc2 = pc_cur + 16'd2;

instruction_mem im(.pc(pc_cur), .instr_out(instr));

assign reg_write_dest = (reg_dst == 1'b1) ? instr[5:3] : instr[8:6];

assign reg_read_addr1 = instr[11:9];
assign reg_read_addr2 = instr[8:6];

reg_file file(.clk(clk),
.write_en(reg_write),
.read_addr1(reg_read_addr1),
.read_addr2(reg_read_addr2),
.write_addr(reg_write_dest),
.write_data(reg_write_data),
.read_data1(reg_read_data1),
.read_data2(reg_read_data2));

assign ext_im = {instr[15:8],instr[15:8]};

alu_control alu1(.ALU_op(alu_op), .opcode(opcode), .ALU_cnt(ALU_control));

assign read_data2 = (alu_src == 1'b1) ? ext_im : reg_read_data2;

alu a(.a(reg_read_data1), .b(read_data2), .alu_sel(ALU_control), .result(ALU_out), .zero_flag(zero_flag));

assign pc_beq = pc2 + {ext_im[14:0],1'b0};
assign pc_bne = pc2 + {ext_im[14:0],1'b0};

assign beq_control = beq & zero_flag;
assign bne_control = bne & ~zero_flag;

assign pc_2beq = (beq_control == 1'b1) ? pc_beq : pc2;
assign pc_2bne = (bne_control == 1'b1) ? pc_bne : pc_2beq;

assign jump_shift = {5{instr[8]},instr[7:0]};
assign pc_j = {pc2[15:13],jump_shift};

assign pc_next = (jump == 1'b1) ? pc_j : pc_2bne;

data_memory data_m(.clk(clk),
.write_en(mem_write),
.read_en(mem_read),
.access_addr(ALU_out),
.write_data(reg_read_data2),
.read_data(mem_read_data));

assign reg_write_data = (mem_to_reg == 1'b1) ? mem_read_data : ALU_out;
assign opcode = instr[15:12];
endmodule

//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

module risc_processor(input clk);

wire jump, bne, beq, mem_read, mem_write, alu_src, reg_dst, mem_to_reg, reg_write;
wire [1:0] alu_op;
wire [3:0] opcode;

data_path dp(.clk(clk),
.jump(jump),
.beq(beq),
.bne(bne),
.mem_read(mem_read),
.mem_write(mem_write),
.alu_src(alu_src),
.reg_dst(reg_dst),
.mem_to_reg(mem_to_reg),
.alu_op(alu_op),
.opcode(opcode),
.reg_write(reg_write)
);

control_unit cu(.opcode(opcode),
.reg_dst(reg_dst),
.mem_to_reg(mem_to_reg),
.alu_op(alu_op),
.jump(jump),
.bne(bne),
.beq(beq),
.mem_read(mem_read),
.mem_write(mem_write),
.alu_src(alu_src),
.reg_write(reg_write));

endmodule

/*----------------------------------------processor--------------------------------------------*/



// -----------------------------------------testbench-------------------------------------------//

/*`timescale 1ns / 1ps
module risc_processor_test();

reg clk;

initial begin
  clk = 0;
  #400 $finish;
end

always begin
    #10 clk = ~clk;
end

risc_processor processor1(.clk(clk));

endmodule