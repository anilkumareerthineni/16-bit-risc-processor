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
    defalut : ALU_cnt = 3'd0;
    endcase
end

endmodule