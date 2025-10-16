module reg_file (input clk, input write_en, input [2:0] read_addr1, input [2:0] read_addr2, input [2:0] write_addr, input [15:0] write_data, output [15:0] read_data1, output [15:0] read_data2);

reg [15:0] reg_mem [0:7];

assign read_data1 = reg_mem[read_addr1];
assign read_data2 = reg_mem[read_addr2];

initial begin
  $readmemh("register_prog.txt",reg_mem);
end

always @(posedge clk) begin
  if(write_en) begin
    reg_mem[write_addr] <= write_data;
  end
end
endmodule