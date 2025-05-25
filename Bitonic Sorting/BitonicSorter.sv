module BitonicSorter (input logic [15:0] a0, a1, a2, a3, a4, a5, a6, a7, a8,
                                        a9, a10, a11, a12, a13, a14, a15,
													 a16, a17, a18, a19, a20, a21, a22, a23,
													 a24, a25, a26, a27, a28, a29, a30, a31,
                    input logic clk, rstN,
                    output logic [15:0] y0, y1, y2, y3, y4, y5, y6, y7,
                                        y8, y9, y10, y11, y12, y13, y14, y15,
													 y16, y17, y18, y19, y20, y21, y22, y23,
													 y24, y25, y26, y27, y28, y29, y30, y31);
//for FSM													 
typedef enum logic [3:0] {state0 = 4'b0000,
								  state1 = 4'b0001,
								  state2 = 4'b0010,
								  state3 = 4'b0100,
								  state4 = 4'b1000} state_t;
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
				 r_reg0, r_reg1, r_reg2, r_reg3,
				 r_reg4, r_reg5, r_reg6, r_reg7,
				 r_reg8, r_reg9, r_reg10, r_reg11,
				 r_reg12, r_reg13, r_reg14, r_reg15,
				 r_reg16, r_reg17, r_reg18, r_reg19, 
				 r_reg20, r_reg21, r_reg22, r_reg23,
				 r_reg24, r_reg25, r_reg26, r_reg27, 
				 r_reg28, r_reg29, r_reg30, r_reg31;
					 
//internal signal for input comparetor				 
logic [15:0] w0_c0, w0_c1, w0_c2, w0_c3, w0_c4, w0_c5, w0_c6, w0_c7,
				 w0_c8, w0_c9, w0_c10, w0_c11, w0_c12, w0_c13, w0_c14, w0_c15,
             w1_c0, w1_c1, w1_c2, w1_c3, w1_c4, w1_c5, w1_c6, w1_c7,
				 w1_c8, w1_c9, w1_c10, w1_c11, w1_c12, w1_c13, w1_c14, w1_c15;
				 
//some internal signals			 
logic [15:0] asc;
logic [2:0] s1;
logic [14:0] s2;

//ajustment of register's output
logic [15:0] int_y0, int_y1, int_y2, int_y3, int_y4, int_y5, int_y6, int_y7,
             int_y8, int_y9, int_y10, int_y11, int_y12, int_y13, int_y14, int_y15,
				 int_y16, int_y17, int_y18, int_y19, int_y20, int_y21, int_y22, int_y23,
				 int_y24, int_y25, int_y26, int_y27, int_y28, int_y29, int_y30, int_y31;

//counter signals
logic [3:0] count_reg, count_next;

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
			count_reg <= count_next;
	  end 

//FSM
always_comb begin
  unique case (state_reg)
		state0: begin
			s1 = 3'b000;
			if (count_reg == 4'b0000)
				state_next = state1;
			else if (count_reg == 4'b0010)
				state_next = state2;
			else if (count_reg == 4'b0101)
				state_next = state3;
			else if (count_reg == 4'b1001)
				state_next = state4;
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
  endcase
end
	  
//counter
assign count_next = (count_reg==4'b1110)?4'b0000:(count_reg+4'b0001);

//s2 and input1 of comperator
always_comb begin
  unique case (s1)
		3'b000: begin
			 s2 = 15'b101010101010101;
			 w1_c0 = r_reg1 ;
			 w1_c1 = r_reg31;
			 w1_c2 = r_reg3;
			 w1_c3 = r_reg29;
			 w1_c4 = r_reg5;
			 w1_c5 = r_reg27;
			 w1_c6 = r_reg7;
			 w1_c7 = r_reg25;
			 w1_c8 = r_reg9;
			 w1_c9 = r_reg23;
			 w1_c10 = r_reg11;
			 w1_c11 = r_reg21;
			 w1_c12 = r_reg13;
			 w1_c13 = r_reg19;
			 w1_c14 = r_reg15;
			 w1_c15 = r_reg17;
		end
		3'b001: begin
			 s2 = 15'b011001100110011;
			 w1_c0 = r_reg2;
			 w1_c1 = r_reg3;
			 w1_c2 = r_reg31;
			 w1_c3 = r_reg30;
			 w1_c4 = r_reg6;
			 w1_c5 = r_reg7;
			 w1_c6 = r_reg27;
			 w1_c7 = r_reg26;
			 w1_c8 = r_reg10;
			 w1_c9 = r_reg11;
			 w1_c10 = r_reg23;
			 w1_c11 = r_reg22;
			 w1_c12 = r_reg14;
			 w1_c13 = r_reg15;
			 w1_c14 = r_reg19;
			 w1_c15 = r_reg18;
		end
		3'b010: begin
			 s2 = 15'b000111100001111;
			 w1_c0 =r_reg4 ;
			 w1_c1 = r_reg5;
			 w1_c2 = r_reg6;
			 w1_c3 = r_reg7;
			 w1_c4 = r_reg31;
			 w1_c5 = r_reg30;
			 w1_c6 = r_reg29;
			 w1_c7 = r_reg28;
			 w1_c8 = r_reg12;
			 w1_c9 = r_reg13;
			 w1_c10 = r_reg14;
			 w1_c11 = r_reg15;
			 w1_c12 = r_reg23;
			 w1_c13 = r_reg22;
			 w1_c14 = r_reg21;
			 w1_c15 = r_reg20;
		end
		3'b011: begin
			 s2 = 15'b000000011111111;
			 w1_c0 =r_reg8 ;
			 w1_c1 = r_reg9;
			 w1_c2 = r_reg10;
			 w1_c3 = r_reg11;
			 w1_c4 = r_reg12;
			 w1_c5 = r_reg13;
			 w1_c6 = r_reg14;
			 w1_c7 = r_reg15;
			 w1_c8 = r_reg31;
			 w1_c9 = r_reg30;
			 w1_c10 = r_reg29;
			 w1_c11 = r_reg28;
			 w1_c12 = r_reg27;
			 w1_c13 = r_reg26;
			 w1_c14 = r_reg25;
			 w1_c15 = r_reg24;
		end
		3'b100: begin
			 s2 = 15'b000000000000000;
			 w1_c0 =r_reg16 ;
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
		end
  endcase
end

//input0 of comperator
assign w0_c1 = s2[14] ? r_reg30:r_reg1 ;
assign w0_c2 = s2[13] ? r_reg29:r_reg2 ;
assign w0_c3 = s2[12] ? r_reg28:r_reg3 ;
assign w0_c4 = s2[11] ? r_reg27:r_reg4 ;
assign w0_c5 = s2[10] ? r_reg26:r_reg5 ;
assign w0_c6 = s2[9] ? r_reg25:r_reg6 ;
assign w0_c7 = s2[8] ? r_reg24:r_reg7 ;
assign w0_c8 = s2[7] ? r_reg23:r_reg8 ;
assign w0_c9 = s2[6] ? r_reg22:r_reg9 ;
assign w0_c10 = s2[5] ? r_reg21:r_reg10 ;
assign w0_c11 = s2[4] ? r_reg20:r_reg11 ;
assign w0_c12 = s2[3] ?  r_reg19:r_reg12 ;
assign w0_c13 = s2[2] ?  r_reg18:r_reg13 ;
assign w0_c14 = s2[1] ?  r_reg17:r_reg14 ;
assign w0_c15 = s2[0] ?  r_reg16:r_reg15 ;

//asc input of comperator
always_comb begin
  asc = 'b0;
  unique case (count_reg)
		4'b0000: asc = 16'b1001100110011001; //count0
		4'b0001: asc = 16'b1100001111000011; //count1
		4'b0010: asc = 16'b1010010110100101; //count2
		4'b0011: asc = 16'b1111000000001111; //count3
		4'b0100: asc = 16'b1100110000110011; //count4
		4'b0101: asc = 16'b1010101001010101; //count5
		4'b0110: asc = 16'b1111111100000000; //count6
		4'b0111: asc = 16'b1111000011110000; //count7
		4'b1000: asc = 16'b1100110011001100; //count8
		4'b1001: asc = 16'b1010101010101010; //count9
		4'b1010: asc = 16'b1111111111111111; //count10
		4'b1011: asc = 16'b1111111111111111; //count11
		4'b1100: asc = 16'b1111111111111111; //count12
		4'b1101: asc = 16'b1111111111111111; //count13
		4'b1110: asc = 16'b1111111111111111; //count14
  endcase
end

//comparetors objects (16 instances)
comparetor c0(r_reg0, w1_c0, asc[15], int_y0, int_y1);
comparetor c1(w0_c1, w1_c1, asc[14], int_y2, int_y3);
comparetor c2(w0_c2, w1_c2, asc[13], int_y4, int_y5);
comparetor c3(w0_c3, w1_c3, asc[12], int_y6, int_y7);
comparetor c4(w0_c4, w1_c4, asc[11], int_y8, int_y9);
comparetor c5(w0_c5, w1_c5, asc[10], int_y10, int_y11);
comparetor c6(w0_c6, w1_c6, asc[9], int_y12, int_y13);
comparetor c7(w0_c7, w1_c7, asc[8], int_y14, int_y15);
comparetor c8(w0_c8, w1_c8, asc[7], int_y16, int_y17);
comparetor c9(w0_c9, w1_c9, asc[6], int_y18, int_y19);
comparetor c10(w0_c10, w1_c10, asc[5], int_y20, int_y21);
comparetor c11(w0_c11, w1_c11, asc[4], int_y22, int_y23);
comparetor c12(w0_c12, w1_c12, asc[3], int_y24, int_y25);
comparetor c13(w0_c13, w1_c13, asc[2], int_y26, int_y27);
comparetor c14(w0_c14, w1_c14, asc[1], int_y28, int_y29);
comparetor c15(w0_c15, w1_c15, asc[0], int_y30, int_y31);

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
			 r_next16 = int_y30;
			 r_next17 = int_y31;
			 r_next18 = int_y26;
			 r_next19 = int_y27;
			 r_next20 = int_y22;
			 r_next21 = int_y23;
			 r_next22 = int_y18;
			 r_next23 = int_y19;
			 r_next24 = int_y14;
			 r_next25 = int_y15;
			 r_next26 = int_y10;
			 r_next27 = int_y11;
			 r_next28 = int_y6;
			 r_next29 = int_y7;
			 r_next30 = int_y2;
			 r_next31 = int_y3;
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
			 r_next16 = int_y30;
			 r_next17 = int_y28;
			 r_next18 = int_y31;
			 r_next19 = int_y29;
			 r_next20 = int_y22;
			 r_next21 = int_y20;
			 r_next22 = int_y23;
			 r_next23 = int_y21;
			 r_next24 = int_y14;
			 r_next25 = int_y12;
			 r_next26 = int_y15;
			 r_next27 = int_y13;
			 r_next28 = int_y6;
			 r_next29 = int_y4;
			 r_next30 = int_y7;
			 r_next31 = int_y5;
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
			 r_next15 = int_y23;
			 r_next16 = int_y30;
			 r_next17 = int_y28;
			 r_next18 = int_y26;
			 r_next19 = int_y24;
			 r_next20 = int_y31;
			 r_next21 = int_y29;
			 r_next22 = int_y27;
			 r_next23 = int_y25;
			 r_next24 = int_y14;
			 r_next25 = int_y12;
			 r_next26 = int_y10;
			 r_next27 = int_y8;
			 r_next28 = int_y15;
			 r_next29 = int_y13;
			 r_next30 = int_y11;
			 r_next31 = int_y9;
			
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
			 r_next16 = int_y30;
			 r_next17 = int_y28;
			 r_next18 = int_y26;
			 r_next19 = int_y24;
			 r_next20 = int_y22;
			 r_next21 = int_y20;
			 r_next22 = int_y18;
			 r_next23 = int_y16;
			 r_next24 = int_y31;
			 r_next25 = int_y29;
			 r_next26 = int_y27;
			 r_next27 = int_y25;
			 r_next28 = int_y23;
			 r_next29 = int_y21;
			 r_next30 = int_y19;
			 r_next31 = int_y17;
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

endmodule 