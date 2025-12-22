// 3-bit register (for func3 field)

module reg_func3 (
    input  logic        clk,
    input  logic        rst,
    input  logic [2:0] d,
    output logic [2:0] q
);
    always_ff @(posedge clk) begin
        if (rst)
            q <= '0;
        else
            q <= d;
    end
endmodule
