// main control unit - decodes instruction opcode and generates control signals

module Main_CU (
    input logic [6:0] opcode,
    input logic [2:0] func3,
    
    // individual control signals
    output logic [1:0] IGC,
    output logic ALUSrc,
    output logic [1:0] ALUOP,
    output logic MemRd,
    output logic MemWr,
    output logic Beq,
    output logic Bne,
    output logic MemToReg,
    output logic RegWr,
    
    // bundled for pipeline
    output logic [6:0] EX_Control,
    output logic [1:0] WB_Control
);

    logic [1:0] IGC_int;
    logic ALUSrc_int;
    logic [1:0] ALUOP_int;
    logic MemRd_int;
    logic MemWr_int;
    logic Beq_int;
    logic Bne_int;
    logic MemToReg_int;
    logic RegWr_int;
    
    always_comb begin
        case (opcode)
            // R-type
            7'b0110011: begin
                IGC_int     = 2'b00;
                ALUSrc_int  = 1'b0;
                ALUOP_int   = 2'b00;
                MemRd_int   = 1'b0;
                MemWr_int   = 1'b0;
                Beq_int     = 1'b0;
                Bne_int     = 1'b0;
                MemToReg_int = 1'b0;
                RegWr_int   = 1'b1;
            end
            
            // I-type (not LW)
            7'b0010011: begin
                IGC_int     = 2'b00;
                ALUSrc_int  = 1'b1;
                ALUOP_int   = 2'b10;
                MemRd_int   = 1'b0;
                MemWr_int   = 1'b0;
                Beq_int     = 1'b0;
                Bne_int     = 1'b0;
                MemToReg_int = 1'b0;
                RegWr_int   = 1'b1;
            end
            
            // LW
            7'b0000011: begin
                IGC_int     = 2'b00;
                ALUSrc_int  = 1'b1;
                ALUOP_int   = 2'b00;
                MemRd_int   = 1'b1;
                MemWr_int   = 1'b0;
                Beq_int     = 1'b0;
                Bne_int     = 1'b0;
                MemToReg_int = 1'b1;
                RegWr_int   = 1'b1;
            end
            
            // SW
            7'b0100011: begin
                IGC_int     = 2'b01;
                ALUSrc_int  = 1'b1;
                ALUOP_int   = 2'b00;
                MemRd_int   = 1'b0;
                MemWr_int   = 1'b1;
                Beq_int     = 1'b0;
                Bne_int     = 1'b0;
                MemToReg_int = 1'b0;
                RegWr_int   = 1'b0;
            end
            
            // branch
            7'b1100011: begin
                IGC_int     = 2'b10;
                ALUSrc_int  = 1'b0;
                ALUOP_int   = 2'b01;
                MemRd_int   = 1'b0;
                MemWr_int   = 1'b0;
                Beq_int     = (func3 == 3'b000) ? 1'b1 : 1'b0;
                Bne_int     = (func3 == 3'b001) ? 1'b1 : 1'b0;
                MemToReg_int = 1'b0;
                RegWr_int   = 1'b0;
            end
            
            default: begin
                IGC_int     = 2'b00;
                ALUSrc_int  = 1'b0;
                ALUOP_int   = 2'b00;
                MemRd_int   = 1'b0;
                MemWr_int   = 1'b0;
                Beq_int     = 1'b0;
                Bne_int     = 1'b0;
                MemToReg_int = 1'b0;
                RegWr_int   = 1'b0;
            end
        endcase
    end
    
    assign IGC = IGC_int;
    assign ALUSrc = ALUSrc_int;
    assign ALUOP = ALUOP_int;
    assign MemRd = MemRd_int;
    assign MemWr = MemWr_int;
    assign Beq = Beq_int;
    assign Bne = Bne_int;
    assign MemToReg = MemToReg_int;
    assign RegWr = RegWr_int;
    
    assign EX_Control = {Bne_int, Beq_int, MemWr_int, MemRd_int, ALUSrc_int, ALUOP_int};
    assign WB_Control = {RegWr_int, MemToReg_int};

endmodule

