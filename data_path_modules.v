module reg_write_mux(select_line, instr, reg_write_dest);

input select_line;
input [15:0] instr;
output [2:0] reg_write_dest;

assign reg_write_dest = (select_line == 1'b1) ? instr[5:3] : instr[8:6];
endmodule


module pc_next_mux(jump, pc_j, pc_2bne, pc_next);
input jump;
input [15:0] pc_j, pc_2bne;
output [15:0] pc_next;

assign pc_next = (jump == 1'b1) ? pc_j : pc_2bne;
endmodule

module reg_write_data_mux(reg_write_data, mem_to_reg, mem_read_data, ALU_out);
input mem_to_reg;
input [15:0] mem_read_data, ALU_out;
output [15:0] reg_write_data;

assign reg_write_data = (mem_to_reg == 1'b1) ? mem_read_data : ALU_out;
endmodule

module read_data2_mux(alu_src, reg_read_data2, ext_im, read_data2);
input alu_src;
input [15:0] ext_im, reg_read_data2;
output [15:0] read_data2;

assign read_data2 = (alu_src == 1'b1) ? ext_im : reg_read_data2;
endmodule
