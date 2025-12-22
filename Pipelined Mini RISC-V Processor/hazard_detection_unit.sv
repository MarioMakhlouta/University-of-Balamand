// hazard detection unit - detects load-use hazards and generates stall signals

module hazard_detection_unit (
    input logic [4:0] rd_ID_ExMem,
    input logic       RegWr_ID_ExMem,
	 input logic       Beq_IF_ID,
	 input logic       Bne_IF_ID,
    input logic [4:0] rs1_addr_IF_ID,
    input logic [4:0] rs2_addr_IF_ID,
    output logic PCenable,
    output logic IRenable,
    output logic nop
);

    always_comb begin
        // detect load-use hazard: LW in ExMem, result needed in IF/ID
        if (RegWr_ID_ExMem && (Beq_IF_ID || Bne_IF_ID) && (rd_ID_ExMem != 5'b00000) && 
            ((rd_ID_ExMem == rs1_addr_IF_ID) || (rd_ID_ExMem == rs2_addr_IF_ID))) begin
            PCenable = 1'b0;
            IRenable = 1'b0;
            nop = 1'b1;
        end else begin
            PCenable = 1'b1;
            IRenable = 1'b1;
            nop = 1'b0;
        end
    end

endmodule

