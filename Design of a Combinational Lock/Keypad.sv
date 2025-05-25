module KeyPad(inout logic [3:0] col,row,
					input logic clk,rstN,
					output logic [3:0] char, keyFlag);

logic OEC,OER,keyPressed,CEC,CER;
typedef enum logic [3:0] {state0,state1,state2,state3,state4,state5,state6,state7,state8,state9} state_t;
state_t state_next, state_reg;

logic [3:0] row_reg, row_next;
logic [3:0] col_reg, col_next;

assign col = OEC?4'b0:4'bZ;
assign row = OER?4'b0:4'bZ;
assign keyPressed = !(col[0]&col[1]&col[2]&col[3]);

always_ff @(posedge clk, negedge rstN)
		if(!rstN)
			state_reg <= state0;
		else 
			state_reg<= state_next;
	
always_ff @(posedge clk, negedge rstN)
		if(!rstN) 
			row_reg <= 'b0;
		else if(CER)
			row_reg <= row_next;
			
always_ff @(posedge clk, negedge rstN)
		if(!rstN) 
			col_reg <= 'b0;
		else if(CEC)
			col_reg <= col_next;
			
assign col_next = col;
assign row_next = row;	
	
always_comb begin
	state_next=state_reg;
	CEC=1'b0;
	CER=1'b0;
	OEC=1'b0;
	OER=1'b0;
	unique case (state_reg)
		state0: begin
			OER=1'b1;
			if(keyPressed)
				state_next=state1;
		end
		state1: 
			state_next=state2;
		state2: 
			state_next=state3;
		state3: begin
			CEC=1'b1;
			state_next=state4;
		end
		state4: begin
			OEC=1'b1;
			state_next=state5;
		end
		state5: begin
			CER=1'b1;
			state_next=state6;
		end
		state6: begin
			OER=1'b1;
			state_next=state7;
		end
		state7:
			if(!keyPressed)
				state_next=state8;
		state8: 
			state_next=state9;
		state9: 
			state_next=state0;
	endcase
end 

always_comb begin
    char = 4'd0; // Default assignment to avoid latch
    if (keyPressed) begin
        unique case ({row_next, col_next})
            8'b01111110: char = 4'b0001;
            8'b01111101: char = 4'b0010;
            8'b01111011: char = 4'b0011;
            8'b01110111: char = 4'b1010; // A
            8'b10111110: char = 4'b0100;
            8'b10111101: char = 4'b0101;
            8'b10111011: char = 4'b0110;
            8'b10110111: char = 4'b1011; // B
            8'b11011110: char = 4'b0111;
            8'b11011101: char = 4'b1000;
            8'b11011011: char = 4'b1001;
            8'b11010111: char = 4'b1100; // C (Clear)
            8'b11101110: char = 4'b1110; // * (optional)
            8'b11101101: char = 4'b0000;
            8'b11101011: char = 4'b1111; // # (Lock)
            8'b11100111: char = 4'b1101; // D (Backspace)
        endcase
    end else begin
        char = 4'd0; // If no key is pressed
    end
end

assign keyFlag = keyPressed; 

endmodule 
		

			