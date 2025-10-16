`include "data_path_modules.v"
`include "alu.v"
`include "alu_control.v"
`include "instruction_mem.v"
`include "register_file.v"
`include "data_memory.v"

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
wire zero_flag;
wire [15:0] pc_j, pc_beq, pc_2beq, pc_2bne, pc_bne;
wire beq_control;
wire [12:0] jump_shift;
wire [15:0] mem_read_data;

always @(posedge clk) begin
  pc_cur <= pc_next;
end

initial begin
    pc_cur <= 16'd0;
end

assign pc2 = pc_cur + 16'd2;
assign opcode = instr[15:12];

instruction_mem im(.pc(pc_cur), .instr_out(instr));

reg_write_mux mux1(.select_line(reg_dst), .instr(instr), .reg_write_dest(reg_write_dest));

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

assign ext_im = {instr[8:0],instr[8:0]};

alu_control alu1(.ALU_op(alu_op), .opcode(opcode), .ALU_cnt(ALU_control));

read_data2_mux read_data2mux1(.alu_src(alu_src), .ext_im(ext_im), .reg_read_data2(reg_read_data2), .read_data2(read_data2));

alu a(.a(reg_read_data1), .b(read_data2), .alu_sel(ALU_control), .result(ALU_out), .zero_flag(zero_flag));

assign pc_beq = pc2 + {ext_im[14:0],1'b0};
assign pc_bne = pc2 + {ext_im[14:0],1'b0};

assign beq_control = beq & zero_flag;
assign bne_control = bne & ~zero_flag;

assign pc_2beq = (beq_control == 1'b1) ? pc_beq : pc2;
assign pc_2bne = (bne_control == 1'b1) ? pc_bne : pc_2beq;

assign jump_shift = {instr[12:7],{10{instr[3]}}};
assign pc_j = {pc2[15:13],jump_shift};

pc_next_mux pc_mux1(.jump(jump), .pc_j(pc_j), .pc_2bne(pc_2bne), .pc_next(pc_next));

data_memory data_m(.clk(clk),
.write_en(mem_write),
.read_en(mem_read),
.access_addr(ALU_out),
.write_data(reg_read_data2),
.read_data(mem_read_data));

reg_write_data_mux reg_write_mux1(.mem_to_reg(mem_to_reg), .mem_read_data(mem_read_data), .ALU_out(ALU_out), .reg_write_data(reg_write_data));

endmodule