// forwarding unit - detects data hazards and generates forwarding control signals

module forwarding_unit (
    input logic [4:0] rs1_addr_ID_ExMem,
    input logic [4:0] rs2_addr_ID_ExMem,
    input logic [4:0] rs1_addr_IF_ID,
    input logic [4:0] rs2_addr_IF_ID,
    input logic [4:0] rd_WB,
    input logic       RegWr_WB,
	 input logic		 MemWr_ID_ExMem,
	 input logic		 MemWr_IF_ID,
	 input logic		 MemRd_ID_ExMem,
	 input logic		 MemRd_IF_ID,
	 input logic		 Beq_IF_ID,
	 input logic		 Bne_IF_ID,
    output logic ForwardA1,
    output logic ForwardB1,
    output logic ForwardA2,
    output logic ForwardB2,
	 output logic ForwardC,
	 output logic ForwardD,
	 output logic ForwardE,
	 output logic ForwardF,
	 output logic ForwardG,
	 output logic ForwardH
);

	 //First Case:
	 //E to E or M to E
    // forward to ID/ExMem stage (no instruction between)
    always_comb begin
        if (RegWr_WB && (rd_WB != 5'b00000) && (rd_WB == rs1_addr_ID_ExMem)) begin
            ForwardA1 = 1'b1;
        end else begin
            ForwardA1 = 1'b0;
        end
    end
    
    always_comb begin
        if (RegWr_WB && (rd_WB != 5'b00000) && (rd_WB == rs2_addr_ID_ExMem)) begin
            ForwardB1 = 1'b1;
        end else begin
            ForwardB1 = 1'b0;
        end
    end
    
    // forward to IF/ID stage (one instruction between)
    always_comb begin
        if (RegWr_WB && (rd_WB != 5'b00000) && (rd_WB == rs1_addr_IF_ID)) begin
            ForwardA2 = 1'b1;
        end else begin
            ForwardA2 = 1'b0;
        end
    end
    
    always_comb begin
        if (RegWr_WB && (rd_WB != 5'b00000) && (rd_WB == rs2_addr_IF_ID)) begin
            ForwardB2 = 1'b1;
        end else begin
            ForwardB2 = 1'b0;
        end
    end
	 
	 
	 
	 
	 //Second Case:
	 //E to M or M to M (WRITE_ADDR input)
	 //0 Instruction between
	 always_comb begin
        if (RegWr_WB && MemWr_ID_ExMem && (rd_WB != 5'b00000) && (rd_WB == rs2_addr_ID_ExMem)) begin
            ForwardC = 1'b1;
        end else begin
            ForwardC = 1'b0;
        end
    end
	 //1 Instruction between
	 always_comb begin
        if (RegWr_WB && MemWr_IF_ID && (rd_WB != 5'b00000) && (rd_WB == rs2_addr_IF_ID)) begin
            ForwardD = 1'b1;
        end else begin
            ForwardD = 1'b0;
        end
    end
	 
	 
	 
	 //Third Case:
	 //E to M or M to M (ADDR input)
	 //and src1 of sw
	 //0 Instruction between
	 always_comb begin
        if ((RegWr_WB && MemRd_ID_ExMem && (rd_WB != 5'b00000) && (rd_WB == rs1_addr_ID_ExMem)) || 
				(RegWr_WB && MemWr_ID_ExMem && (rd_WB != 5'b00000) && (rd_WB == rs1_addr_ID_ExMem))) begin
            ForwardE = 1'b1;
        end else begin
            ForwardE = 1'b0;
        end
    end
	 //1 Instruction between
	 always_comb begin
        if ((RegWr_WB && MemRd_IF_ID && (rd_WB != 5'b00000) && (rd_WB == rs1_addr_IF_ID)) ||
				(RegWr_WB && MemWr_IF_ID && (rd_WB != 5'b00000) && (rd_WB == rs1_addr_IF_ID)))begin
            ForwardF = 1'b1;
        end else begin
            ForwardF = 1'b0;
        end
    end
	 
//	 //src1 in sw
//	 //0 Instruction between
//	 always_comb begin
//        if (RegWr_WB && MemWr_ID_ExMem && (rd_WB != 5'b00000) && (rd_WB == rs1_addr_ID_ExMem)) begin
//            ForwardE = 1'b1;
//        end else begin
//            ForwardE = 1'b0;
//        end
//    end
//	 //1 Instruction between
//	 always_comb begin
//        if (RegWr_WB && MemWr_IF_ID && (rd_WB != 5'b00000) && (rd_WB == rs1_addr_IF_ID)) begin
//            ForwardF = 1'b1;
//        end else begin
//            ForwardF = 1'b0;
//        end
//    end

	 
	 
	 
	 
	 //Fourth Case:
	 //E to D or M to D (for beq and bne)
	 always_comb begin
        if (RegWr_WB && (Beq_IF_ID || Bne_IF_ID) && (rd_WB != 5'b00000) && (rd_WB == rs1_addr_IF_ID)) begin
            ForwardG = 1'b1;
        end else begin
            ForwardG = 1'b0;
        end
    end
    
    always_comb begin
        if (RegWr_WB && (Beq_IF_ID || Bne_IF_ID) && (rd_WB != 5'b00000) && (rd_WB == rs2_addr_IF_ID)) begin
            ForwardH = 1'b1;
        end else begin
            ForwardH = 1'b0;
        end
    end

endmodule

