// Example Integration of Hazard Detection Unit in Pipeline
// Shows how to connect hazard detection unit and handle stalls
//
// Pipeline Structure:
// IF -> ID -> EX/MEM -> WB

module hazard_integration_example (
    input logic clk,
    input logic reset
);

    // ========== Pipeline Stage Signals ==========
    
    // IF Stage
    logic [31:0] PC_value;
    logic [31:0] PC_next;
    logic        PC_enable;       // Controlled by hazard detection unit
    
    // IF/ID Pipeline Register
    logic [31:0] IF_ID_instruction;
    logic [31:0] IF_ID_PC_plus_4;
    logic        IF_ID_write_enable;  // Controlled by hazard detection unit
    
    // ID Stage
    logic [4:0]  rs1_addr_ID;     // From instruction decode
    logic [4:0]  rs2_addr_ID;     // From instruction decode
    
    // EX/MEM Pipeline Register
    logic [4:0]  EX_MEM_rd;       // Destination register
    logic        EX_MEM_MemRd;    // Memory read signal (from control)
    
    // ========== Hazard Detection Unit ==========
    
    logic Stall;                  // Hazard detected
    logic PCWrite;                // PC write enable (inverted Stall)
    logic IF_IDWrite;             // IF/ID write enable (inverted Stall)
    logic ID_EX_Flush;            // ID/EX flush signal
    
    hazard_detection_unit hazard_unit (
        .rd_MEM(EX_MEM_rd),
        .MemRd_MEM(EX_MEM_MemRd),
        .rs1_addr_ID(rs1_addr_ID),
        .rs2_addr_ID(rs2_addr_ID),
        .Stall(Stall),
        .PCWrite(PCWrite),
        .IF_IDWrite(IF_IDWrite),
        .ID_EX_Flush(ID_EX_Flush)
    );
    
    // ========== Stall Control ==========
    
    // PC update controlled by hazard detection
    assign PC_enable = PCWrite;
    
    // IF/ID register update controlled by hazard detection
    assign IF_ID_write_enable = IF_IDWrite;
    
    // ID/EX register flush (insert bubble/NOP)
    // When ID_EX_Flush = 1, clear all control signals and use NOP instruction
    
    // ========== Example: Load-Use Hazard ==========
    //
    // Cycle 1: LW x1, 0(x2) enters EX/MEM
    //          ADD x3, x1, x4 enters ID
    //          Hazard detected!
    //
    // Cycle 2: Stall pipeline
    //          - PC stays same
    //          - IF/ID holds ADD instruction
    //          - ID/EX gets NOP (bubble)
    //          - EX/MEM gets LW result from memory
    //
    // Cycle 3: Normal operation resumes
    //          - ADD x3, x1, x4 can now forward from WB stage
    
    // ========== PC Module ==========
    
    pc pc_module (
        .clk(clk),
        .reset(reset),
        .pc_next(PC_next),
        .pc_enable(PC_enable),    // Controlled by hazard unit
        .pc_value(PC_value)
    );
    
    // ========== IF/ID Pipeline Register ==========
    
    always_ff @(posedge clk) begin
        if (reset) begin
            IF_ID_instruction <= 32'h00000013;  // NOP (ADDI x0, x0, 0)
            IF_ID_PC_plus_4 <= 32'd0;
        end else if (IF_ID_write_enable) begin  // Controlled by hazard unit
            IF_ID_instruction <= instruction_from_imem;
            IF_ID_PC_plus_4 <= PC_value + 32'd4;
        end
        // If IF_ID_write_enable = 0, register holds previous value (stall)
    end
    
    // ========== ID/EX Pipeline Register ==========
    
    // When ID_EX_Flush = 1, insert NOP (clear control signals)
    // This creates a bubble in the pipeline
    
    always_ff @(posedge clk) begin
        if (reset || ID_EX_Flush) begin  // Flush on hazard
            // Insert NOP: Clear all control signals
            ID_EX_rs1 <= 5'b00000;
            ID_EX_rs2 <= 5'b00000;
            ID_EX_control <= 7'b0000000;  // All control signals off
            // ... other ID/EX signals cleared
        end else begin
            // Normal pipeline propagation
            ID_EX_rs1 <= rs1_addr_ID;
            ID_EX_rs2 <= rs2_addr_ID;
            ID_EX_control <= control_from_main_cu;
            // ... other ID/EX signals
        end
    end

endmodule

