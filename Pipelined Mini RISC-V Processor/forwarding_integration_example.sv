// Example Integration of Forwarding Unit in Pipeline
// This shows how to connect the forwarding unit to the pipeline
// 
// Pipeline Structure:
// IF -> ID -> EX/MEM -> WB
//
// Forwarding Unit connects:
// - Inputs: rs1, rs2 from ID/EX, rd from EX/MEM and MEM/WB
// - Outputs: ForwardA, ForwardB control signals
// - Forwarding MUXes select data for ALU inputs

module forwarding_integration_example (
    input logic clk,
    input logic reset
);

    // ========== Pipeline Register Signals ==========
    
    // ID/EX Pipeline Register (between Decode and Execute)
    logic [4:0]  ID_EX_rs1;      // Source register 1 from ID stage
    logic [4:0]  ID_EX_rs2;      // Source register 2 from ID stage
    logic [31:0] ID_EX_rs1_data; // Register file data for rs1
    logic [31:0] ID_EX_rs2_data; // Register file data for rs2
    
    // EX/MEM Pipeline Register (between Execute and Memory)
    logic [4:0]  EX_MEM_rd;      // Destination register from EX stage
    logic [31:0] EX_MEM_ALU_result; // ALU result (to be forwarded)
    logic        EX_MEM_RegWr;    // Register write enable (from control)
    
    // MEM/WB Pipeline Register (between Memory and Write-Back)
    logic [4:0]  MEM_WB_rd;      // Destination register from MEM stage
    logic [31:0] MEM_WB_ALU_result; // ALU result from MEM stage
    logic [31:0] MEM_WB_Mem_data;   // Memory read data (for LW)
    logic        MEM_WB_RegWr;      // Register write enable (WB_Control[1])
    logic        MEM_WB_MemToReg;   // Memory to register select (WB_Control[0])
    logic [31:0] MEM_WB_write_data;  // Final write data (ALU or memory)
    
    // ========== Forwarding Unit ==========
    
    logic [1:0] ForwardA;  // Forwarding control for ALU input A
    logic [1:0] ForwardB;  // Forwarding control for ALU input B
    
    forwarding_unit fwd_unit (
        .rs1_addr(ID_EX_rs1),
        .rs2_addr(ID_EX_rs2),
        .rd_MEM(EX_MEM_rd),
        .RegWr_MEM(EX_MEM_RegWr),
        .rd_WB(MEM_WB_rd),
        .RegWr_WB(MEM_WB_RegWr),
        .ForwardA(ForwardA),
        .ForwardB(ForwardB)
    );
    
    // ========== Forwarding MUXes ==========
    
    logic [31:0] ALU_input_A;  // ALU input A (after forwarding)
    logic [31:0] ALU_input_B;  // ALU input B (after forwarding)
    
    // MUX for ALU input A (rs1)
    forwarding_mux mux_A (
        .regfile_data(ID_EX_rs1_data),
        .mem_stage_data(EX_MEM_ALU_result),
        .wb_stage_data(MEM_WB_write_data),
        .forward_sel(ForwardA),
        .alu_input(ALU_input_A)
    );
    
    // MUX for ALU input B (rs2)
    forwarding_mux mux_B (
        .regfile_data(ID_EX_rs2_data),
        .mem_stage_data(EX_MEM_ALU_result),
        .wb_stage_data(MEM_WB_write_data),
        .forward_sel(ForwardB),
        .alu_input(ALU_input_B)
    );
    
    // ========== Write-Back Data Selection ==========
    // Select between ALU result and memory data for write-back
    assign MEM_WB_write_data = MEM_WB_MemToReg ? MEM_WB_Mem_data : MEM_WB_ALU_result;
    
    // ========== Example Usage ==========
    //
    // Case 1: EX Hazard
    //   ADD x1, x2, x3  (in MEM stage)
    //   SUB x4, x1, x1  (in EX stage)
    //   - ForwardA = 01 (forward from MEM)
    //   - ForwardB = 01 (forward from MEM)
    //
    // Case 2: MEM Hazard
    //   ADD x1, x2, x3  (in WB stage)
    //   SUB x4, x1, x5  (in EX stage)
    //   - ForwardA = 10 (forward from WB)
    //   - ForwardB = 00 (use register file)
    //
    // Case 3: Load-Use Hazard (requires stall, not handled by forwarding)
    //   LW x1, 0(x2)    (in MEM stage)
    //   ADD x3, x1, x4  (in EX stage)
    //   - Cannot forward (data not ready until end of MEM stage)
    //   - Must insert bubble/stall

endmodule

