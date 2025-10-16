`include "data_path.v"
`include "control_unit.v"
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

