// 7-bit register (for func7 field)

module reg_func7 (
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
