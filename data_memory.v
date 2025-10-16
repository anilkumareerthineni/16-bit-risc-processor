module data_memory (input clk, input write_en, input read_en, input [15:0] access_addr, input [15:0] write_data, output [15:0] read_data);

reg [15:0] memory [0:7];

wire [2:0] addr = access_addr[2:0];
initial begin
    $readmemh("memory_prog.txt",memory);
end

always @(posedge clk) begin
    if(write_en) begin
        memory[addr] <= write_data;
    end
end

assign read_data = (read_en == 1'b1) ? memory[addr] : 16'd0;

endmodule