module instruction_mem (input [15:0] pc, output [15:0] instr_out);

reg [15:0] memory [0:15];

wire [3:0] addr = pc[4:1];

assign instr_out = memory[addr];

initial begin
    $readmemh("instruction_prog.txt",memory);
end

endmodule