// PC adder - adds 4 to current PC for next instruction
// simple combinational adder

module pc_adder (
    input logic [31:0] pc_current,
    output logic [31:0] pc_plus_4
);

    assign pc_plus_4 = pc_current + 32'd4;

endmodule

