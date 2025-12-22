// ALU control unit - generates ALU operation code from ALUOP, func3, func7

module ALU_CU (
    input logic [1:0] ALUOP,
    input logic [2:0] func3,
    input logic [6:0] func7,
    output logic [3:0] ALU
);

    always_comb begin
        case (ALUOP)
            // R-type
            2'b00: begin
                if (func3 == 3'b010) begin
                    if (func7 == 7'b0000000) begin
                        ALU = 4'b1000;  // SLT
                    end else begin
                        ALU = 4'b0000;  // LW/SW, don't care
                    end
                end else begin
                    case ({func7[5], func3})
                        {1'b0, 3'b000}: ALU = 4'b0000;  // ADD
                        {1'b1, 3'b000}: ALU = 4'b0001;  // SUB
                        {1'b0, 3'b001}: ALU = 4'b0010;  // SLL
                        {1'b0, 3'b011}: ALU = 4'b1001;  // SLTU
                        {1'b0, 3'b100}: ALU = 4'b0011;  // XOR
                        {1'b0, 3'b101}: ALU = 4'b0100;  // SRL
                        {1'b1, 3'b101}: ALU = 4'b0101;  // SRA
                        {1'b0, 3'b110}: ALU = 4'b0110;  // OR
                        {1'b0, 3'b111}: ALU = 4'b0111;  // AND
                        default:        ALU = 4'b0000;
                    endcase
                end
            end
            
            // I-type
            2'b10: begin
                case (func3)
                    3'b000: ALU = 4'b0000;  // ADDI
                    3'b001: begin
                        if (func7[5] == 1'b0) begin
                            ALU = 4'b0010;  // SLLI
                        end else begin
                            ALU = 4'b0000;
                        end
                    end
                    3'b010: ALU = 4'b1000;  // SLTI
                    3'b011: ALU = 4'b1001;  // SLTIU
                    3'b100: ALU = 4'b0011;  // XORI
                    3'b101: begin
                        if (func7[5] == 1'b0) begin
                            ALU = 4'b0100;  // SRLI
                        end else begin
                            ALU = 4'b0101;  // SRAI
                        end
                    end
                    3'b110: ALU = 4'b0110;  // ORI
                    3'b111: ALU = 4'b0111;  // ANDI
                    default: ALU = 4'b0000;
                endcase
            end
            
            // branch
            2'b01: begin
                ALU = 4'b0001;  // SUB for comparison
            end
            
            default: begin
                ALU = 4'b0000;
            end
        endcase
    end

endmodule

