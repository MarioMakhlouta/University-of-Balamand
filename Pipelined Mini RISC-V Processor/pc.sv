// Program counter - holds current instruction address
// Can be updated or held during stalls

module pc (
    input logic clk,
    input logic reset,
    input logic [31:0] pc_next,
    input logic pc_enable,
    output logic [31:0] pc_value
);

    always_ff @(posedge clk) begin
        if (reset) begin
            pc_value <= 32'd0;
        end else begin
            if (pc_enable) begin
                pc_value <= pc_next;
            end
        end
    end

endmodule

