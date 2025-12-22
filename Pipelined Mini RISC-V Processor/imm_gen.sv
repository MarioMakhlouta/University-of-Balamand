// immediate generator - extracts and sign-extends immediate from instruction

module imm_gen (
    input  logic [24:0] IR_in,   // IR[31:7] compressed
    input  logic [1:0]  IGC,     // 00=I, 01=S, 10=B
    output logic [31:0] Im
);

    logic IR31;
    logic [5:0] IR30_25;
    logic [3:0] IR11_8;
    logic IR7;
    logic [11:0] IR31_20;
    logic [6:0]  IR31_25;
    logic [4:0]  IR11_7;
    
    assign IR31 = IR_in[24];
    assign IR30_25 = IR_in[23:18];
    assign IR11_8  = IR_in[4:1];
    assign IR7  = IR_in[0];
    assign IR31_20 = {IR_in[24:13]};
    assign IR31_25 = {IR_in[24:18]};
    assign IR11_7  = {IR_in[4:0]};

    logic [31:0] imm_i;
    logic [31:0] imm_s;
    logic [31:0] imm_b;

    // I-type immediate
    always_comb begin
        imm_i[11:0]   = IR31_20;
        imm_i[31:12]  = {20{IR31}};
    end

    // S-type immediate
    always_comb begin
        imm_s[4:0]    = IR11_7;
        imm_s[11:5]   = IR31_25;
        imm_s[31:12]  = {20{IR31}};
    end

    // B-type immediate
    always_comb begin
        imm_b[0]      = 1'b0;
        imm_b[4:1]    = IR11_8;
        imm_b[10:5]   = IR30_25;
        imm_b[11]     = IR7;
        imm_b[12]     = IR31;
        imm_b[31:13]  = {19{IR31}};
    end

    always_comb begin
        unique case (IGC)
            2'b00: Im = imm_i;
            2'b01: Im = imm_s;
            2'b10: Im = imm_b;
            default: Im = imm_i;
        endcase
    end

endmodule


