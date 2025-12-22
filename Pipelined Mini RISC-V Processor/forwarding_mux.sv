// Forwarding Multiplexer for ALU Inputs
// Selects between register file data, MEM stage data, or WB stage data
// Based on forwarding control signals from forwarding_unit

module forwarding_mux (
    // Register file data (from ID stage)
    input logic [31:0] regfile_data,     // Data from register file (rs1_data or rs2_data)
    
    // Data from MEM stage (EX/MEM pipeline register)
    input logic [31:0] mem_stage_data,   // ALU result from MEM stage
    
    // Data from WB stage (MEM/WB pipeline register)
    input logic [31:0] wb_stage_data,    // ALU result or memory data from WB stage
    
    // Forwarding control signal
    input logic [1:0]  forward_sel,      // Forwarding select from forwarding_unit
                                         // 00: Use register file data
                                         // 01: Forward from MEM stage
                                         // 10: Forward from WB stage
    
    // Output to ALU
    output logic [31:0] alu_input       // Selected data to ALU input (A or B)
);

    always_comb begin
        case (forward_sel)
            2'b00: alu_input = regfile_data;      // Use register file data
            2'b01: alu_input = mem_stage_data;    // Forward from MEM stage
            2'b10: alu_input = wb_stage_data;     // Forward from WB stage
            default: alu_input = regfile_data;    // Default to register file
        endcase
    end

endmodule

