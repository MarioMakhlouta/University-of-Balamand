// EX/MEM pipeline register (7 bits: ALUOP(2), ALUSrc, MemRd, MemWr, beq, bne)

module reg_ExMem (
    input  logic        clk,
    input  logic        rst,
    input  logic [6:0] d,
    output logic [6:0] q
);
    always_ff @(posedge clk) begin
        if (rst)
            q <= '0;
        else
            q <= d;
    end
endmodule