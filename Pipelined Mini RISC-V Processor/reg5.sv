// 5-bit register (for register addresses)

module reg5 (
    input  logic        clk,
    input  logic        rst,
    input  logic [4:0] d,
    output logic [4:0] q
);
    always_ff @(posedge clk) begin
        if (rst)
            q <= '0;
        else
            q <= d;
    end
endmodule
