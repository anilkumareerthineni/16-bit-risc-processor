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