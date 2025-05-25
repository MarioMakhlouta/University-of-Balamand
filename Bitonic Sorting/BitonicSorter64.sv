module BitonicSorter64 (input logic [15:0] a0, a1, a2, a3, a4, a5, a6, a7, a8,
                                        a9, a10, a11, a12, a13, a14, a15,
													 a16, a17, a18, a19, a20, a21, a22, a23,
													 a24, a25, a26, a27, a28, a29, a30, a31,
													 a32, a33, a34, a35, a36, a37, a38, a39,
													 a40, a41, a42, a43, a44, a45, a46, a47,
													 a48, a49, a50, a51, a52, a53, a54, a55,
													 a56, a57, a58, a59, a60, a61, a62, a63,
                    input logic clk, rstN,
                    output logic [15:0] y0, y1, y2, y3, y4, y5, y6, y7,
                                        y8, y9, y10, y11, y12, y13, y14, y15,
													 y16, y17, y18, y19, y20, y21, y22, y23,
													 y24, y25, y26, y27, y28, y29, y30, y31,
													 y32, y33, y34, y35, y36, y37, y38, y39,
													 y40, y41, y42, y43, y44, y45, y46, y47,
													 y48, y49, y50, y51, y52, y53, y54, y55,
													 y56, y57, y58, y59, y60, y61, y62, y63);
//for FSM													 
typedef enum logic [4:0] {state0 = 5'b00000,
								  state1 = 5'b00001,
								  state2 = 5'b00010,
								  state3 = 5'b00100,
								  state4 = 5'b01000,
								  state5 = 5'b10000} state_t;
state_t state_next, state_reg;

//internal signals for registers
logic [15:0] r_next0, r_next1, r_next2, r_next3,
				 r_next4, r_next5, r_next6, r_next7,
				 r_next8, r_next9, r_next10, r_next11,
				 r_next12, r_next13, r_next14, r_next15,
				 r_next16, r_next17, r_next18, r_next19, 
				 r_next20, r_next21, r_next22, r_next23,
				 r_next24, r_next25, r_next26, r_next27, 
				 r_next28, r_next29, r_next30, r_next31,
				 r_next32, r_next33, r_next34, r_next35,
				 r_next36, r_next37, r_next38, r_next39,
				 r_next40, r_next41, r_next42, r_next43,
				 r_next44, r_next45, r_next46, r_next47,
				 r_next48, r_next49, r_next50, r_next51, 
				 r_next52, r_next53, r_next54, r_next55,
				 r_next56, r_next57, r_next58, r_next59, 
				 r_next60, r_next61, r_next62, r_next63,
				 r_reg0, r_reg1, r_reg2, r_reg3,
				 r_reg4, r_reg5, r_reg6, r_reg7,
				 r_reg8, r_reg9, r_reg10, r_reg11,
				 r_reg12, r_reg13, r_reg14, r_reg15,
				 r_reg16, r_reg17, r_reg18, r_reg19, 
				 r_reg20, r_reg21, r_reg22, r_reg23,
				 r_reg24, r_reg25, r_reg26, r_reg27, 
				 r_reg28, r_reg29, r_reg30, r_reg31,
				 r_reg32, r_reg33, r_reg34, r_reg35,
				 r_reg36, r_reg37, r_reg38, r_reg39,
				 r_reg40, r_reg41, r_reg42, r_reg43,
				 r_reg44, r_reg45, r_reg46, r_reg47,
				 r_reg48, r_reg49, r_reg50, r_reg51, 
				 r_reg52, r_reg53, r_reg54, r_reg55,
				 r_reg56, r_reg57, r_reg58, r_reg59, 
				 r_reg60, r_reg61, r_reg62, r_reg63;
					 
//internal signal for input comparetor				 
logic [15:0] w0_c0, w0_c1, w0_c2, w0_c3, w0_c4, w0_c5, w0_c6, w0_c7,
				 w0_c8, w0_c9, w0_c10, w0_c11, w0_c12, w0_c13, w0_c14, w0_c15,
				 w0_c16, w0_c17, w0_c18, w0_c19, w0_c20, w0_c21, w0_c22, w0_c23,
				 w0_c24, w0_c25, w0_c26, w0_c27, w0_c28, w0_c29, w0_c30, w0_c31,
             w1_c0, w1_c1, w1_c2, w1_c3, w1_c4, w1_c5, w1_c6, w1_c7,
				 w1_c8, w1_c9, w1_c10, w1_c11, w1_c12, w1_c13, w1_c14, w1_c15,
				 w1_c16, w1_c17, w1_c18, w1_c19, w1_c20, w1_c21, w1_c22, w1_c23,
				 w1_c24, w1_c25, w1_c26, w1_c27, w1_c28, w1_c29, w1_c30, w1_c31;
				 
//some internal signals			 
logic [31:0] asc;
logic [2:0] s1;
logic [30:0] s2;

//ajustment of register's output
logic [15:0] int_y0, int_y1, int_y2, int_y3, int_y4, int_y5, int_y6, int_y7,
             int_y8, int_y9, int_y10, int_y11, int_y12, int_y13, int_y14, int_y15,
				 int_y16, int_y17, int_y18, int_y19, int_y20, int_y21, int_y22, int_y23,
				 int_y24, int_y25, int_y26, int_y27, int_y28, int_y29, int_y30, int_y31,
				 int_y32, int_y33, int_y34, int_y35, int_y36, int_y37, int_y38, int_y39,
             int_y40, int_y41, int_y42, int_y43, int_y44, int_y45, int_y46, int_y47,
				 int_y48, int_y49, int_y50, int_y51, int_y52, int_y53, int_y54, int_y55,
				 int_y56, int_y57, int_y58, int_y59, int_y60, int_y61, int_y62, int_y63;

//counter signals
logic [4:0] count_reg, count_next;

//Sequentiel Part					 
always_ff @(posedge clk, negedge rstN)
	  if(!rstN) begin
			state_reg <= state0;
			r_reg0 <= a0;
			r_reg1 <= a1;
			r_reg2 <= a2;
			r_reg3 <= a3;
			r_reg4 <= a4;
			r_reg5 <= a5;
			r_reg6 <= a6;
			r_reg7 <= a7;
			r_reg8 <= a8;
			r_reg9 <= a9;
			r_reg10 <= a10;
			r_reg11 <= a11;
			r_reg12 <= a12;
			r_reg13 <= a13;
			r_reg14 <= a14;
			r_reg15 <= a15;
			r_reg16 <= a16;
			r_reg17 <= a17;
			r_reg18 <= a18;
			r_reg19 <= a19;
			r_reg20 <= a20;
			r_reg21 <= a21;
			r_reg22 <= a22;
			r_reg23 <= a23;
			r_reg24 <= a24;
			r_reg25 <= a25;
			r_reg26 <= a26;
			r_reg27 <= a27;
			r_reg28 <= a28;
			r_reg29 <= a29;
			r_reg30 <= a30;
			r_reg31 <= a31;
			r_reg32 <= a32;
			r_reg33 <= a33;
			r_reg34 <= a34;
			r_reg35 <= a35;
			r_reg36 <= a36;
			r_reg37 <= a37;
			r_reg38 <= a38;
			r_reg39 <= a39;
			r_reg40 <= a40;
			r_reg41 <= a41;
			r_reg42 <= a42;
			r_reg43 <= a43;
			r_reg44 <= a44;
			r_reg45 <= a45;
			r_reg46 <= a46;
			r_reg47 <= a47;
			r_reg48 <= a48;
			r_reg49 <= a49;
			r_reg50 <= a50;
			r_reg51 <= a51;
			r_reg52 <= a52;
			r_reg53 <= a53;
			r_reg54 <= a54;
			r_reg55 <= a55;
			r_reg56 <= a56;
			r_reg57 <= a57;
			r_reg58 <= a58;
			r_reg59 <= a59;
			r_reg60 <= a60;
			r_reg61 <= a61;
			r_reg62 <= a62;
			r_reg63 <= a63;
			count_reg <= 'b0;
	  end
	  else begin
			state_reg <= state_next;
			r_reg0 <= r_next0;
			r_reg1 <= r_next1;
			r_reg2 <= r_next2;
			r_reg3 <= r_next3;
			r_reg4 <= r_next4;
			r_reg5 <= r_next5;
			r_reg6 <= r_next6;
			r_reg7 <= r_next7;
			r_reg8 <= r_next8;
			r_reg9 <= r_next9;
			r_reg10 <= r_next10;
			r_reg11 <= r_next11;
			r_reg12 <= r_next12;
			r_reg13 <= r_next13;
			r_reg14 <= r_next14;
			r_reg15 <= r_next15;
			r_reg16 <= r_next16;
			r_reg17 <= r_next17;
			r_reg18 <= r_next18;
			r_reg19 <= r_next19;
			r_reg20 <= r_next20;
			r_reg21 <= r_next21;
			r_reg22 <= r_next22;
			r_reg23 <= r_next23;
			r_reg24 <= r_next24;
			r_reg25 <= r_next25;
			r_reg26 <= r_next26;
			r_reg27 <= r_next27;
			r_reg28 <= r_next28;
			r_reg29 <= r_next29;
			r_reg30 <= r_next30;
			r_reg31 <= r_next31;
			r_reg32 <= r_next32;
			r_reg33 <= r_next33;
			r_reg34 <= r_next34;
			r_reg35 <= r_next35;
			r_reg36 <= r_next36;
			r_reg37 <= r_next37;
			r_reg38 <= r_next38;
			r_reg39 <= r_next39;
			r_reg40 <= r_next40;
			r_reg41 <= r_next41;
			r_reg42 <= r_next42;
			r_reg43 <= r_next43;
			r_reg44 <= r_next44;
			r_reg45 <= r_next45;
			r_reg46 <= r_next46;
			r_reg47 <= r_next47;
			r_reg48 <= r_next48;
			r_reg49 <= r_next49;
			r_reg50 <= r_next50;
			r_reg51 <= r_next51;
			r_reg52 <= r_next52;
			r_reg53 <= r_next53;
			r_reg54 <= r_next54;
			r_reg55 <= r_next55;
			r_reg56 <= r_next56;
			r_reg57 <= r_next57;
			r_reg58 <= r_next58;
			r_reg59 <= r_next59;
			r_reg60 <= r_next60;
			r_reg61 <= r_next61;
			r_reg62 <= r_next62;
			r_reg63 <= r_next63;
			count_reg <= count_next;
	  end 

//FSM
always_comb begin
  unique case (state_reg)
		state0: begin
			s1 = 3'b000;
			if (count_reg == 5'b00000)
				state_next = state1;
			else if (count_reg == 5'b00010)
				state_next = state2;
			else if (count_reg == 5'b00101)
				state_next = state3;
			else if (count_reg == 5'b01001)
				state_next = state4;
			else if (count_reg == 5'b01110)
				state_next = state5;
			else
				state_next = state0;
		end
		state1: begin
			s1 = 3'b001;
			state_next = state0;
		end
		state2: begin
			s1 = 3'b010;
			state_next = state1;
		end
		state3: begin
			s1 = 3'b011;
			state_next = state2;
		end
		state4: begin
			s1 = 3'b100;
			state_next = state3;
		end 
		state5: begin
			s1 = 3'b101;
			state_next = state4;
		end 
  endcase
end
	  
//counter
assign count_next = (count_reg==5'b10100)?5'b00000:(count_reg+5'b00001);

//s2 and input1 of comperator
always_comb begin
  unique case (s1)
		3'b000: begin
			 s2 = 32'b1010101010101010101010101010101;
			 w1_c0 = r_reg1;
			 w1_c1 = r_reg63;
			 w1_c2 = r_reg3;
			 w1_c3 = r_reg61;
			 w1_c4 = r_reg5;
			 w1_c5 = r_reg59;
			 w1_c6 = r_reg7;
			 w1_c7 = r_reg57;
			 w1_c8 = r_reg9;
			 w1_c9 = r_reg55;
			 w1_c10 = r_reg11;
			 w1_c11 = r_reg53;
			 w1_c12 = r_reg13;
			 w1_c13 = r_reg51;
			 w1_c14 = r_reg15;
			 w1_c15 = r_reg49;
			 w1_c16 = r_reg17;
			 w1_c17 = r_reg47;
			 w1_c18 = r_reg19;
			 w1_c19 = r_reg45;
			 w1_c20 = r_reg21;
			 w1_c21 = r_reg43;
			 w1_c22 = r_reg23;
			 w1_c23 = r_reg41;
			 w1_c24 = r_reg25;
			 w1_c25 = r_reg39;
			 w1_c26 = r_reg27;
			 w1_c27 = r_reg37;
			 w1_c28 = r_reg29;
			 w1_c29 = r_reg35;
			 w1_c30 = r_reg31;
			 w1_c31 = r_reg33;
		end
		3'b001: begin
			 s2 = 32'b0110011001100110011001100110011;
			 w1_c0 = r_reg2;
			 w1_c1 = r_reg3;
			 w1_c2 = r_reg63;
			 w1_c3 = r_reg62;
			 w1_c4 = r_reg6;
			 w1_c5 = r_reg7;
			 w1_c6 = r_reg59;
			 w1_c7 = r_reg58;
			 w1_c8 = r_reg10;
			 w1_c9 = r_reg11;
			 w1_c10 = r_reg55;
			 w1_c11 = r_reg54;
			 w1_c12 = r_reg14;
			 w1_c13 = r_reg15;
			 w1_c14 = r_reg51;
			 w1_c15 = r_reg50;
			 w1_c16 = r_reg18;
			 w1_c17 = r_reg19;
			 w1_c18 = r_reg47;
			 w1_c19 = r_reg46;
			 w1_c20 = r_reg22;
			 w1_c21 = r_reg23;
			 w1_c22 = r_reg43;
			 w1_c23 = r_reg42;
			 w1_c24 = r_reg26;
			 w1_c25 = r_reg27;
			 w1_c26 = r_reg39;
			 w1_c27 = r_reg38;
			 w1_c28 = r_reg30;
			 w1_c29 = r_reg31;
			 w1_c30 = r_reg35;
			 w1_c31 = r_reg34;
		end
		3'b010: begin
			 s2 = 32'b0001111000011110000111100001111;
			 w1_c0 = r_reg4;
			 w1_c1 = r_reg5;
			 w1_c2 = r_reg6;
			 w1_c3 = r_reg7;
			 w1_c4 = r_reg63;
			 w1_c5 = r_reg62;
			 w1_c6 = r_reg61;
			 w1_c7 = r_reg60;
			 w1_c8 = r_reg12;
			 w1_c9 = r_reg13;
			 w1_c10 = r_reg14;
			 w1_c11 = r_reg15;
			 w1_c12 = r_reg55;
			 w1_c13 = r_reg54;
			 w1_c14 = r_reg53;
			 w1_c15 = r_reg52;
			 w1_c16 = r_reg20;
			 w1_c17 = r_reg21;
			 w1_c18 = r_reg22;
			 w1_c19 = r_reg23;
			 w1_c20 = r_reg47;
			 w1_c21 = r_reg46;
			 w1_c22 = r_reg45;
			 w1_c23 = r_reg44;
			 w1_c24 = r_reg28;
			 w1_c25 = r_reg29;
			 w1_c26 = r_reg30;
			 w1_c27 = r_reg31;
			 w1_c28 = r_reg39;
			 w1_c29 = r_reg38;
			 w1_c30 = r_reg37;
			 w1_c31 = r_reg36;
		end
		3'b011: begin
			 s2 = 32'b0000000111111110000000011111111;
			 w1_c0 = r_reg8;
			 w1_c1 = r_reg9;
			 w1_c2 = r_reg10;
			 w1_c3 = r_reg11;
			 w1_c4 = r_reg12;
			 w1_c5 = r_reg13;
			 w1_c6 = r_reg14;
			 w1_c7 = r_reg15;
			 w1_c8 = r_reg63;
			 w1_c9 = r_reg62;
			 w1_c10 = r_reg61;
			 w1_c11 = r_reg60;
			 w1_c12 = r_reg59;
			 w1_c13 = r_reg58;
			 w1_c14 = r_reg57;
			 w1_c15 = r_reg56;
			 w1_c16 = r_reg24;
			 w1_c17 = r_reg25;
			 w1_c18 = r_reg26;
			 w1_c19 = r_reg27;
			 w1_c20 = r_reg28;
			 w1_c21 = r_reg29;
			 w1_c22 = r_reg30;
			 w1_c23 = r_reg31;
			 w1_c24 = r_reg47;
			 w1_c25 = r_reg46;
			 w1_c26 = r_reg45;
			 w1_c27 = r_reg44;
			 w1_c28 = r_reg43;
			 w1_c29 = r_reg42;
			 w1_c30 = r_reg41;
			 w1_c31 = r_reg40;
		end
		3'b100: begin
			 s2 = 32'b0000000000000001111111111111111;
			 w1_c0 = r_reg16;
			 w1_c1 = r_reg17;
			 w1_c2 = r_reg18;
			 w1_c3 = r_reg19;
			 w1_c4 = r_reg20;
			 w1_c5 = r_reg21;
			 w1_c6 = r_reg22;
			 w1_c7 = r_reg23;
			 w1_c8 = r_reg24;
			 w1_c9 = r_reg25;
			 w1_c10 = r_reg26;
			 w1_c11 = r_reg27;
			 w1_c12 = r_reg28;
			 w1_c13 = r_reg29;
			 w1_c14 = r_reg30;
			 w1_c15 = r_reg31;
			 w1_c16 = r_reg63;
			 w1_c17 = r_reg62;
			 w1_c18 = r_reg61;
			 w1_c19 = r_reg60;
			 w1_c20 = r_reg59;
			 w1_c21 = r_reg58;
			 w1_c22 = r_reg57;
			 w1_c23 = r_reg56;
			 w1_c24 = r_reg55;
			 w1_c25 = r_reg54;
			 w1_c26 = r_reg53;
			 w1_c27 = r_reg52;
			 w1_c28 = r_reg51;
			 w1_c29 = r_reg50;
			 w1_c30 = r_reg49;
			 w1_c31 = r_reg48;
		end
		3'b101: begin
			 s2 = 32'b0000000000000000000000000000000;
			 w1_c0 = r_reg32;
			 w1_c1 = r_reg33;
			 w1_c2 = r_reg34;
			 w1_c3 = r_reg35;
			 w1_c4 = r_reg36;
			 w1_c5 = r_reg37;
			 w1_c6 = r_reg38;
			 w1_c7 = r_reg39;
			 w1_c8 = r_reg40;
			 w1_c9 = r_reg41;
			 w1_c10 = r_reg42;
			 w1_c11 = r_reg43;
			 w1_c12 = r_reg44;
			 w1_c13 = r_reg45;
			 w1_c14 = r_reg46;
			 w1_c15 = r_reg47;
			 w1_c16 = r_reg48;
			 w1_c17 = r_reg49;
			 w1_c18 = r_reg50;
			 w1_c19 = r_reg51;
			 w1_c20 = r_reg52;
			 w1_c21 = r_reg53;
			 w1_c22 = r_reg54;
			 w1_c23 = r_reg55;
			 w1_c24 = r_reg56;
			 w1_c25 = r_reg57;
			 w1_c26 = r_reg58;
			 w1_c27 = r_reg59;
			 w1_c28 = r_reg60;
			 w1_c29 = r_reg61;
			 w1_c30 = r_reg62;
			 w1_c31 = r_reg63;
		end
  endcase
end

//input0 of comperator
assign w0_c1 = s2[30] ? r_reg62:r_reg1;
assign w0_c2 = s2[29] ? r_reg61:r_reg2;
assign w0_c3 = s2[28] ? r_reg60:r_reg3;
assign w0_c4 = s2[27] ? r_reg59:r_reg4;
assign w0_c5 = s2[26] ? r_reg58:r_reg5;
assign w0_c6 = s2[25] ? r_reg57:r_reg6;
assign w0_c7 = s2[24] ? r_reg56:r_reg7;
assign w0_c8 = s2[23] ? r_reg55:r_reg8;
assign w0_c9 = s2[22] ? r_reg54:r_reg9;
assign w0_c10 = s2[21] ? r_reg53:r_reg10;
assign w0_c11 = s2[20] ? r_reg52:r_reg11;
assign w0_c12 = s2[19] ? r_reg51:r_reg12;
assign w0_c13 = s2[18] ? r_reg50:r_reg13;
assign w0_c14 = s2[17] ? r_reg49:r_reg14;
assign w0_c15 = s2[16] ? r_reg48:r_reg15;
assign w0_c16 = s2[15] ? r_reg47:r_reg16;
assign w0_c17 = s2[14] ? r_reg46:r_reg17;
assign w0_c18 = s2[13] ? r_reg45:r_reg18;
assign w0_c19 = s2[12] ? r_reg44:r_reg19;
assign w0_c20 = s2[11] ? r_reg43:r_reg20;
assign w0_c21 = s2[10] ? r_reg42:r_reg21;
assign w0_c22 = s2[9] ? r_reg41:r_reg22;
assign w0_c23 = s2[8] ? r_reg40:r_reg23;
assign w0_c24 = s2[7] ? r_reg39:r_reg24;
assign w0_c25 = s2[6] ? r_reg38:r_reg25;
assign w0_c26 = s2[5] ? r_reg37:r_reg26;
assign w0_c27 = s2[4] ? r_reg36:r_reg27;
assign w0_c28 = s2[3] ? r_reg35:r_reg28;
assign w0_c29 = s2[2] ? r_reg34:r_reg29;
assign w0_c30 = s2[1] ? r_reg33:r_reg30;
assign w0_c31 = s2[0] ? r_reg32:r_reg31;

//asc input of comperator
always_comb begin
  asc = 'b0;
  unique case (count_reg)
		5'b00000: asc = 32'b10011001100110011001100110011001; //count0
		5'b00001: asc = 32'b11000011110000111100001111000011; //count1
		5'b00010: asc = 32'b10100101101001011010010110100101; //count2
		5'b00011: asc = 32'b11110000000011111111000000001111; //count3
		5'b00100: asc = 32'b11001100001100111100110000110011; //count4
		5'b00101: asc = 32'b10101010010101011010101001010101; //count5
		5'b00110: asc = 32'b11111111000000001111111100000000; //count6
		5'b00111: asc = 32'b11110000111100001111000011110000; //count7
		5'b01000: asc = 32'b11001100110011001100110011001100; //count8
		5'b01001: asc = 32'b10101010101010101010101010101010; //count9
		5'b01010: asc = 32'b11111111111111110000000000000000; //count10
		5'b01011: asc = 32'b11111111000000001111111100000000; //count11
		5'b01100: asc = 32'b11110000111100001111000011110000; //count12
		5'b01101: asc = 32'b11001100110011001100110011001100; //count13
		5'b01110: asc = 32'b10101010101010101010101010101010; //count14
		5'b01111: asc = 32'b11111111111111111111111111111111; //count15
		5'b10000: asc = 32'b11111111111111111111111111111111; //count16
		5'b10001: asc = 32'b11111111111111111111111111111111; //count17
		5'b10010: asc = 32'b11111111111111111111111111111111; //count18
		5'b10011: asc = 32'b11111111111111111111111111111111; //count19
		5'b10100: asc = 32'b11111111111111111111111111111111; //count20
  endcase
end

//comparetors objects (16 instances)
comparetor c0(r_reg0, w1_c0, asc[31], int_y0, int_y1);
comparetor c1(w0_c1, w1_c1, asc[30], int_y2, int_y3);
comparetor c2(w0_c2, w1_c2, asc[29], int_y4, int_y5);
comparetor c3(w0_c3, w1_c3, asc[28], int_y6, int_y7);
comparetor c4(w0_c4, w1_c4, asc[27], int_y8, int_y9);
comparetor c5(w0_c5, w1_c5, asc[26], int_y10, int_y11);
comparetor c6(w0_c6, w1_c6, asc[25], int_y12, int_y13);
comparetor c7(w0_c7, w1_c7, asc[24], int_y14, int_y15);
comparetor c8(w0_c8, w1_c8, asc[23], int_y16, int_y17);
comparetor c9(w0_c9, w1_c9, asc[22], int_y18, int_y19);
comparetor c10(w0_c10, w1_c10, asc[21], int_y20, int_y21);
comparetor c11(w0_c11, w1_c11, asc[20], int_y22, int_y23);
comparetor c12(w0_c12, w1_c12, asc[19], int_y24, int_y25);
comparetor c13(w0_c13, w1_c13, asc[18], int_y26, int_y27);
comparetor c14(w0_c14, w1_c14, asc[17], int_y28, int_y29);
comparetor c15(w0_c15, w1_c15, asc[16], int_y30, int_y31);
comparetor c16(w0_c16, w1_c16, asc[15], int_y32, int_y33);
comparetor c17(w0_c17, w1_c17, asc[14], int_y34, int_y35);
comparetor c18(w0_c18, w1_c18, asc[13], int_y36, int_y37);
comparetor c19(w0_c19, w1_c19, asc[12], int_y38, int_y39);
comparetor c20(w0_c20, w1_c20, asc[11], int_y40, int_y41);
comparetor c21(w0_c21, w1_c21, asc[10], int_y42, int_y43);
comparetor c22(w0_c22, w1_c22, asc[9], int_y44, int_y45);
comparetor c23(w0_c23, w1_c23, asc[8], int_y46, int_y47);
comparetor c24(w0_c24, w1_c24, asc[7], int_y48, int_y49);
comparetor c25(w0_c25, w1_c25, asc[6], int_y50, int_y51);
comparetor c26(w0_c26, w1_c26, asc[5], int_y52, int_y53);
comparetor c27(w0_c27, w1_c27, asc[4], int_y54, int_y55);
comparetor c28(w0_c28, w1_c28, asc[3], int_y56, int_y57);
comparetor c29(w0_c29, w1_c29, asc[2], int_y58, int_y59);
comparetor c30(w0_c30, w1_c30, asc[1], int_y60, int_y61);
comparetor c31(w0_c31, w1_c31, asc[0], int_y62, int_y63);

//internal signals and feedback registers (r_next)
always_comb begin
  r_next0 = int_y0;
  unique case (s1)
		3'b000: begin
			 r_next1 = int_y1;
			 r_next2 = int_y4;
			 r_next3 = int_y5;
			 r_next4 = int_y8;
			 r_next5 = int_y9;
			 r_next6 = int_y12;
			 r_next7 = int_y13;
			 r_next8 = int_y16;
			 r_next9 = int_y17;
			 r_next10 = int_y20;
			 r_next11 = int_y21;
			 r_next12 = int_y24;
			 r_next13 = int_y25;
			 r_next14 = int_y28;
			 r_next15 = int_y29;
			 r_next16 = int_y32;
			 r_next17 = int_y33;
			 r_next18 = int_y36;
			 r_next19 = int_y37;
			 r_next20 = int_y40;
			 r_next21 = int_y41;
			 r_next22 = int_y44;
			 r_next23 = int_y45;
			 r_next24 = int_y48;
			 r_next25 = int_y49;
			 r_next26 = int_y52;
			 r_next27 = int_y53;
			 r_next28 = int_y56;
			 r_next29 = int_y57;
			 r_next30 = int_y60;
			 r_next31 = int_y61;
			 r_next32 = int_y62;
			 r_next33 = int_y63;
			 r_next34 = int_y58;
			 r_next35 = int_y59;
			 r_next36 = int_y54;
			 r_next37 = int_y55;
			 r_next38 = int_y50;
			 r_next39 = int_y51;
			 r_next40 = int_y46;
			 r_next41 = int_y47;
			 r_next42 = int_y42;
			 r_next43 = int_y43;
			 r_next44 = int_y38;
			 r_next45 = int_y39;
			 r_next46 = int_y34;
			 r_next47 = int_y35;
			 r_next48 = int_y30;
			 r_next49 = int_y31;
			 r_next50 = int_y26;
			 r_next51 = int_y27;
			 r_next52 = int_y22;
			 r_next53 = int_y23;
			 r_next54 = int_y18;
			 r_next55 = int_y19;
			 r_next56 = int_y14;
			 r_next57 = int_y15;
			 r_next58 = int_y10;
			 r_next59 = int_y11;
			 r_next60 = int_y6;
			 r_next61 = int_y7;
			 r_next62 = int_y2;
			 r_next63 = int_y3;
		end
		3'b001: begin
			 r_next1 = int_y2;
			 r_next2 = int_y1;
			 r_next3 = int_y3;
			 r_next4 = int_y8;
			 r_next5 = int_y10;
			 r_next6 = int_y9;
			 r_next7 = int_y11;
			 r_next8 = int_y16;
			 r_next9 = int_y18;
			 r_next10 = int_y17;
			 r_next11 = int_y19;
			 r_next12 = int_y24;
			 r_next13 = int_y26;
			 r_next14 = int_y25;
			 r_next15 = int_y27;
			 r_next16 = int_y32;
			 r_next17 = int_y34;
			 r_next18 = int_y33;
			 r_next19 = int_y35;
			 r_next20 = int_y40;
			 r_next21 = int_y42;
			 r_next22 = int_y41;
			 r_next23 = int_y43;
			 r_next24 = int_y48;
			 r_next25 = int_y50;
			 r_next26 = int_y49;
			 r_next27 = int_y51;
			 r_next28 = int_y56;
			 r_next29 = int_y58;
			 r_next30 = int_y57;
			 r_next31 = int_y59;
			 r_next32 = int_y62;
			 r_next33 = int_y60;
			 r_next34 = int_y63;
			 r_next35= int_y61;
			 r_next36= int_y54;
			 r_next37 = int_y52;
			 r_next38= int_y55;
			 r_next39= int_y53;
			 r_next40= int_y46;
			 r_next41 = int_y44;
			 r_next42 = int_y47;
			 r_next43 = int_y45;
			 r_next44 = int_y38;
			 r_next45 = int_y36;
			 r_next46 = int_y39;
			 r_next47 = int_y37;
			 r_next48 = int_y30;
			 r_next49 = int_y28;
			 r_next50 = int_y31;
			 r_next51 = int_y29;
			 r_next52 = int_y22;
			 r_next53 = int_y20;
			 r_next54 = int_y23;
			 r_next55 = int_y21;
			 r_next56 = int_y14;
			 r_next57 = int_y12;
			 r_next58 = int_y15;
			 r_next59 = int_y13;
			 r_next60 = int_y6;
			 r_next61 = int_y4;
			 r_next62 = int_y7;
			 r_next63=int_y5;
			 end
			 
		3'b010: begin
			 r_next1 = int_y2;
			 r_next2 = int_y4;
			 r_next3 = int_y6;
			 r_next4 = int_y1;
			 r_next5 = int_y3;
			 r_next6 = int_y5;
			 r_next7 = int_y7;
			 r_next8 = int_y16;
			 r_next9 = int_y18;
			 r_next10 = int_y20;
			 r_next11 = int_y22;
			 r_next12 = int_y17;
			 r_next13 = int_y19;
			 r_next14 = int_y21;
			 r_next15 = int_y31;
			 r_next16 = int_y34;
			 r_next17 = int_y36;
			 r_next18 = int_y38;
			 r_next19 = int_y33;
			 r_next20 = int_y35;
			 r_next21 = int_y37;
			 r_next22 = int_y39;
			 r_next23 = int_y48;
			 r_next24 = int_y50;
			 r_next25 = int_y52;
			 r_next26 = int_y54;
			 r_next27 = int_y49;
			 r_next28 = int_y51;
			 r_next29 = int_y53;
			 r_next30 = int_y55;
			 r_next31 = int_y57;
			 r_next32 = int_y62;
			 r_next33 = int_y60;
			 r_next34 = int_y58;
			 r_next35 = int_y56;
			 r_next36 = int_y63;
			 r_next37 = int_y61;
			 r_next38 = int_y59;
			 r_next39 = int_y57;
			 r_next40 = int_y46;
			 r_next41 = int_y44;
			 r_next42 = int_y42;
			 r_next43 = int_y40;
			 r_next44 = int_y47;
			 r_next45 = int_y45;
			 r_next46 = int_y43;
			 r_next47 = int_y41;
			 r_next48 = int_y30;
			 r_next49 = int_y28;
			 r_next50 = int_y26;
			 r_next51 = int_y24;
			 r_next52 = int_y31;
			 r_next53 = int_y29;
			 r_next54 = int_y27;
			 r_next55 = int_y25;
			 r_next56 = int_y14;
			 r_next57 = int_y12;
			 r_next58 = int_y10;
			 r_next59 = int_y8;
			 r_next60 = int_y15;
			 r_next61 = int_y13;
			 r_next62 = int_y11;
			 r_next63 = int_y9;
		end
		3'b011: begin
			r_next1 = int_y2;
			 r_next2 = int_y4;
			 r_next3 = int_y6;
			 r_next4 = int_y8;
			 r_next5 = int_y10;
			 r_next6 = int_y12;
			 r_next7 = int_y14;
			 r_next8 = int_y1;
			 r_next9 = int_y3;
			 r_next10 = int_y5;
			 r_next11 = int_y7;
			 r_next12 = int_y9;
			 r_next13 = int_y11;
			 r_next14 = int_y13;
			 r_next15 = int_y15;
			 r_next16 = int_y32;
			 r_next17 = int_y34;
			 r_next18 = int_y36;
			 r_next19 = int_y38;
			 r_next20 = int_y40;
			 r_next21 = int_y42;
			 r_next22 = int_y44;
			 r_next23 = int_y46;
			 r_next24 = int_y33;
			 r_next25 = int_y35;
			 r_next26 = int_y37;
			 r_next27 = int_y39;
			 r_next28 = int_y41;
			 r_next29 = int_y43;
			 r_next30 = int_y45;
			 r_next31 = int_y47;
			 r_next32 = int_y62;
			 r_next33 = int_y60;
			 r_next34 = int_y58;
			 r_next35 = int_y56;
			 r_next36 = int_y54;
			 r_next37 = int_y52;
			 r_next38 = int_y50;
			 r_next39 = int_y48;
			 r_next40 = int_y63;
			 r_next41 = int_y61;
			 r_next42 = int_y59;
			 r_next43 = int_y57;
			 r_next44 = int_y55;
			 r_next45 = int_y53;
			 r_next46 = int_y51;
			 r_next47 = int_y49;
			 r_next48 = int_y30;
			 r_next49 = int_y28;
			 r_next50 = int_y26;
			 r_next51 = int_y24;
			 r_next52 = int_y22;
			 r_next53 = int_y20;
			 r_next54 = int_y18;
			 r_next55 = int_y16;
			 r_next56 = int_y31;
			 r_next57 = int_y29;
			 r_next58 = int_y27;
			 r_next59 = int_y25;
			 r_next60 = int_y23;
			 r_next61 = int_y21;
			 r_next62 = int_y19;
			 r_next63 = int_y17;
		end
		3'b100: begin
			 r_next1 = int_y2;
			 r_next2 = int_y4;
			 r_next3 = int_y6;
			 r_next4 = int_y8;
			 r_next5 = int_y10;
			 r_next6 = int_y12;
			 r_next7 = int_y14;
			 r_next8 = int_y16;
			 r_next9 = int_y18;
			 r_next10 = int_y20;
			 r_next11 = int_y22;
			 r_next12 = int_y24;
			 r_next13 = int_y26;
			 r_next14 = int_y28;
			 r_next15 = int_y30;
			 r_next16 = int_y1;
			 r_next17 = int_y3;
			 r_next18 = int_y5;
			 r_next19 = int_y7;
			 r_next20 = int_y9;
			 r_next21 = int_y11;
			 r_next22 = int_y13;
			 r_next23 = int_y15;
			 r_next24 = int_y17;
			 r_next25 = int_y19;
			 r_next26 = int_y21;
			 r_next27 = int_y23;
			 r_next28 = int_y25;
			 r_next29 = int_y27;
			 r_next30 = int_y29;
			 r_next31 = int_y31;
			 r_next32 = int_y62;
			 r_next33 = int_y60;
			 r_next34 = int_y58;
			 r_next35 = int_y56;
			 r_next36 = int_y54;
			 r_next37 = int_y52;
			 r_next38 = int_y50;
			 r_next39 = int_y48;
			 r_next40 = int_y46;
			 r_next41 = int_y44;
			 r_next42 = int_y42;
			 r_next43 = int_y40;
			 r_next44 = int_y38;
			 r_next45 = int_y36;
			 r_next46 = int_y34;
			 r_next47 = int_y32;
			 r_next48 = int_y63;
			 r_next49 = int_y61;
			 r_next50 = int_y59;
			 r_next51 = int_y57;
			 r_next52 = int_y55;
			 r_next53 = int_y53;
			 r_next54 = int_y51;
			 r_next55 = int_y49;
			 r_next56 = int_y47;
			 r_next57 = int_y45;
			 r_next58 = int_y43;
			 r_next59 = int_y41;
			 r_next60 = int_y39;
			 r_next61 = int_y37;
			 r_next62 = int_y35;
			 r_next63 = int_y33;
		end
		3'b101: begin
			 r_next1 = int_y2;
			 r_next2 = int_y4;
			 r_next3 = int_y6;
			 r_next4 = int_y8;
			 r_next5 = int_y10;
			 r_next6 = int_y12;
			 r_next7 = int_y14;
			 r_next8 = int_y16;
			 r_next9 = int_y18;
			 r_next10 = int_y20;
			 r_next11 = int_y22;
			 r_next12 = int_y24;
			 r_next13 = int_y26;
			 r_next14 = int_y28;
			 r_next15 = int_y30;
			 r_next16 = int_y32;
			 r_next17 = int_y34;
			 r_next18 = int_y36;
			 r_next19 = int_y38;
			 r_next20 = int_y40;
			 r_next21 = int_y42;
			 r_next22 = int_y44;
			 r_next23 = int_y46;
			 r_next24 = int_y48;
			 r_next25 = int_y50;
			 r_next26 = int_y52;
			 r_next27 = int_y54;
			 r_next28 = int_y56;
			 r_next29 = int_y58;
			 r_next30 = int_y60;
			 r_next31 = int_y62;
			 r_next32 = int_y1;
			 r_next33 = int_y3;
			 r_next34 = int_y5;
			 r_next35 = int_y7;
			 r_next36 = int_y9;
			 r_next37 = int_y11;
			 r_next38 = int_y13;
			 r_next39 = int_y15;
			 r_next40 = int_y17;
			 r_next41 = int_y19;
			 r_next42 = int_y21;
			 r_next43 = int_y23;
			 r_next44 = int_y25;
			 r_next45 = int_y27;
			 r_next46 = int_y29;
			 r_next47 = int_y31;
			 r_next48 = int_y33;
			 r_next49 = int_y35;
			 r_next50 = int_y37;
			 r_next51 = int_y39;
			 r_next52 = int_y41;
			 r_next53 = int_y43;
			 r_next54 = int_y45;
			 r_next55 = int_y47;
			 r_next56 = int_y49;
			 r_next57 = int_y51;
			 r_next58 = int_y53;
			 r_next59 = int_y55;
			 r_next60 = int_y57;
			 r_next61 = int_y59;
			 r_next62 = int_y61;
			 r_next63 = int_y63;
		end
  endcase
end

//the final output
assign y0 = r_reg0; 
assign y1 = r_reg1;
assign y2 = r_reg2;
assign y3 = r_reg3;
assign y4 = r_reg4;
assign y5 = r_reg5;
assign y6 = r_reg6;
assign y7 = r_reg7;
assign y8 = r_reg8;
assign y9 = r_reg9;
assign y10 = r_reg10;
assign y11 = r_reg11;
assign y12 = r_reg12;
assign y13 = r_reg13;
assign y14 = r_reg14;
assign y15 = r_reg15;
assign y16 = r_reg16;
assign y17 = r_reg17;
assign y18 = r_reg18;
assign y19 = r_reg19;
assign y20 = r_reg20;
assign y21 = r_reg21;
assign y22 = r_reg22;
assign y23 = r_reg23;
assign y24 = r_reg24;
assign y25 = r_reg25;
assign y26 = r_reg26;
assign y27 = r_reg27;
assign y28 = r_reg28;
assign y29 = r_reg29;
assign y30 = r_reg30;
assign y31 = r_reg31;
assign y32 = r_reg32; 
assign y33 = r_reg33;
assign y34 = r_reg34;
assign y35 = r_reg35;
assign y36 = r_reg36;
assign y37 = r_reg37;
assign y38 = r_reg38;
assign y39 = r_reg39;
assign y40 = r_reg40;
assign y41 = r_reg41;
assign y42 = r_reg42;
assign y43 = r_reg43;
assign y44 = r_reg44;
assign y45 = r_reg45;
assign y46 = r_reg46;
assign y47 = r_reg47;
assign y48 = r_reg48;
assign y49 = r_reg49;
assign y50 = r_reg50;
assign y51 = r_reg51;
assign y52 = r_reg52;
assign y53 = r_reg53;
assign y54 = r_reg54;
assign y55 = r_reg55;
assign y56 = r_reg56;
assign y57 = r_reg57;
assign y58 = r_reg58;
assign y59 = r_reg59;
assign y60 = r_reg60;
assign y61 = r_reg61;
assign y62 = r_reg62;
assign y63 = r_reg63;

endmodule 