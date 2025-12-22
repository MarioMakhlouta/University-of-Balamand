// 32-bit comparator - checks if two operands are equal

module comparator_32bit (
    input logic [31:0] a,
    input logic [31:0] b,
    output logic equal
);

    assign equal = (a == b) ? 1'b1 : 1'b0;

endmodule

