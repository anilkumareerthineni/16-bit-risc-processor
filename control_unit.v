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

