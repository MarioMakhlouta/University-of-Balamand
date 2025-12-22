// ALU module - handles all arithmetic and logic operations
// Inputs: two 32-bit operands and 4-bit operation select
// Outputs: 32-bit result and zero flag

module alu (
    input logic [31:0] A,      // first operand
    input logic [31:0] B,      // second operand
    input logic [3:0]  ALU_sel, // operation selector
    output logic [31:0] y,     // result output
    output logic z              // zero flag
);

    logic [31:0] result;
    
    // main ALU operations
    always_comb begin
        case (ALU_sel)
            4'b0000: result = A + B;                    // add
            4'b0001: result = A - B;                    // subtract
            4'b0010: result = A << B[4:0];              // shift left
            4'b0011: result = A ^ B;                    // xor
            4'b0100: result = A >> B[4:0];              // shift right logical
            4'b0101: result = $signed(A) >>> B[4:0];    // shift right arithmetic
            4'b0110: result = A | B;                    // or
            4'b0111: result = A & B;                    // and
            4'b1000: result = ($signed(A) < $signed(B)) ? 32'd1 : 32'd0;  // set less than (signed)
            4'b1001: result = (A < B) ? 32'd1 : 32'd0;  // set less than (unsigned)
            default: result = 32'd0;
        endcase
    end
    
    assign y = result;
    assign z = (result == 32'd0) ? 1'b1 : 1'b0;

endmodule

