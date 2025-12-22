// Register file - 32 registers, x0 hardwired to zero
// Can read from two registers and write to one per cycle

module regfile (
    input logic clk,
    input logic reset,
    
    // read addresses and data
    input logic [4:0]  rs1_addr,
    output logic [31:0] rs1_data,
    input logic [4:0]  rs2_addr,
    output logic [31:0] rs2_data,
    
    // write port
    input logic [4:0]  rd_addr,
    input logic [31:0] rd_data,
    input logic        reg_write
);

    // only store x1-x31, x0 is always zero
    logic [31:0] registers [1:31];
    
    // init registers for testing
    initial begin
        for (int i = 1; i < 32; i++) begin
            registers[i] = 32'(i);
        end
    end
    
    // reads are combinational
    // x0 always returns zero
    assign rs1_data = (rs1_addr == 5'b00000) ? 32'd0 : registers[rs1_addr];
    assign rs2_data = (rs2_addr == 5'b00000) ? 32'd0 : registers[rs2_addr];
    
    // writes happen on clock edge
    always_ff @(posedge clk) begin
        if (reset) begin
            for (int i = 1; i < 32; i++) begin
                registers[i] <= 32'd0;
            end
        end else begin
            // can't write to x0
            if (reg_write && (rd_addr != 5'b00000)) begin
                registers[rd_addr] <= rd_data;
            end
        end
    end

endmodule

