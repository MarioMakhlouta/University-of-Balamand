// 32-bit pipeline register with enable (for IF/ID stage)

module reg32_IR(
    input  logic        clk,
    input logic         enable,
    input  logic        rst,
    input  logic [31:0] d,
    output logic [31:0] q
);
    always_ff @(posedge clk) begin
        if (rst)
            q <= '0;
        else if (enable)
            q <= d;
    end
endmodule
