module bitonic_sort (input logic [7:0] a0, a1, a2, a3, a4, a5, a6, a7, a8,
                                        a9, a10, a11, a12, a13, a14, a15,
                    input logic clk, arstN,
                    output logic [7:0] y0, y1, y2, y3, y4, y5, y6, y7,
                                        y8, y9, y10, y11, y12, y13, y14, y15);

    typedef enum logic [3:0] {state0 = 4'b0001,
                                state1 = 4'b0010,
                                state2 = 4'b0100,
                                state3 = 4'b1000} state_t;
    state_t state_next, state_reg;

    logic [7:0] r_next0, r_next1, r_next2, r_next3,
                r_next4, r_next5, r_next6, r_next7,
                r_next8, r_next9, r_next10, r_next11,
                r_next12, r_next13, r_next14, r_next15,
					 r_reg0, r_reg1, r_reg2, r_reg3,
                r_reg4, r_reg5, r_reg6, r_reg7,
                r_reg8, r_reg9, r_reg10, r_reg11,
                r_reg12, r_reg13, r_reg14, r_reg15;
	logic CE;
	 
	logic [7:0] w0_c0, w0_c1, w0_c2, w0_c3, w0_c4, w0_c5, w0_c6, w0_c7,
                w1_c0, w1_c1, w1_c2, w1_c3, w1_c4, w1_c5, w1_c6, w1_c7;
    logic [7:0] a_d;
    logic [1:0] s1;
    logic [6:0] s2;
    logic [7:0] int_y0, int_y1, int_y2, int_y3, int_y4, int_y5, int_y6, int_y7,
                int_y8, int_y9, int_y10, int_y11, int_y12, int_y13, int_y14, int_y15;
    
    logic [3:0] count_reg, count_next;

    always_ff @(posedge clk, negedge arstN)
        if(!arstN) begin
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
			count_reg <= 'b0;
        end
        else if(CE) begin
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
			count_reg <= count_next;
        end
		  
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

    always_comb begin
        case (s1)
            2'b00: begin
                s2 = 7'b1010101;
                w1_c0 = r_reg1;
                w1_c1 = r_reg15;
                w1_c2 = r_reg3;
                w1_c3 = r_reg13;
                w1_c4 = r_reg5;
                w1_c5 = r_reg11;
                w1_c6 = r_reg7;
                w1_c7 = r_reg9;
            end
            2'b01: begin
                s2 = 7'b0110011;
                w1_c0 = r_reg2;
                w1_c1 = r_reg3;
                w1_c2 = r_reg15;
                w1_c3 = r_reg14;
                w1_c4 = r_reg6;
                w1_c5 = r_reg7;
                w1_c6 = r_reg11;
                w1_c7 = r_reg10;
            end
            2'b10: begin
                s2 = 7'b0001111;
                w1_c0 = r_reg4;
                w1_c1 = r_reg5;
                w1_c2 = r_reg6;
                w1_c3 = r_reg7;
                w1_c4 = r_reg15;
                w1_c5 = r_reg14;
                w1_c6 = r_reg13;
                w1_c7 = r_reg12;
            end
            2'b11: begin
                s2 = 7'b0000000;
                w1_c0 = r_reg8;
                w1_c1 = r_reg9;
                w1_c2 = r_reg10;
                w1_c3 = r_reg11;
                w1_c4 = r_reg12;
                w1_c5 = r_reg13;
                w1_c6 = r_reg14;
                w1_c7 = r_reg15;
            end
        endcase
    end

    assign w0_c1 = s2[6] ? r_reg14 : r_reg1;
    assign w0_c2 = s2[5] ? r_reg13 : r_reg2;
    assign w0_c3 = s2[4] ? r_reg12 : r_reg3;
    assign w0_c4 = s2[3] ? r_reg11 : r_reg4;
    assign w0_c5 = s2[2] ? r_reg10 : r_reg5;
    assign w0_c6 = s2[1] ? r_reg9 : r_reg6;
    assign w0_c7 = s2[0] ? r_reg8 : r_reg7;

    always_comb begin
        a_d = 'b0;
        CE = 1'b1;
        unique case (count_reg)
            4'b0000: a_d = 8'b10011001;
            4'b0001: a_d = 8'b11000011;
            4'b0010: a_d = 8'b10100101;
            4'b0011: a_d = 8'b11110000;
            4'b0100: a_d = 8'b11001100;
            4'b0101: a_d = 8'b10101010;
            4'b0110: a_d = 8'b11111111;
            4'b0111: a_d = 8'b11111111;
            4'b1000: a_d = 8'b11111111;
            4'b1001: a_d = 8'b11111111;
            4'b1010: CE = 1'b0;
        endcase
    end

    compare c0(r_reg0, w1_c0, a_d[7], int_y0, int_y1);
    compare c1(w0_c1, w1_c1, a_d[6], int_y2, int_y3);
    compare c2(w0_c2, w1_c2, a_d[5], int_y4, int_y5);
    compare c3(w0_c3, w1_c3, a_d[4], int_y6, int_y7);
    compare c4(w0_c4, w1_c4, a_d[3], int_y8, int_y9);
    compare c5(w0_c5, w1_c5, a_d[2], int_y10, int_y11);
    compare c6(w0_c6, w1_c6, a_d[1], int_y12, int_y13);
    compare c7(w0_c7, w1_c7, a_d[0], int_y14, int_y15);

    always_comb begin
        r_next0 = int_y0;
        case (s1)
            2'b00: begin
                r_next1 = int_y1;
                r_next2 = int_y4;
                r_next3 = int_y5;
                r_next4 = int_y8;
                r_next5 = int_y9;
                r_next6 = int_y12;
                r_next7 = int_y13;
                r_next8 = int_y14;
                r_next9 = int_y15;
                r_next10 = int_y10;
                r_next11 = int_y11;
                r_next12 = int_y6;
                r_next13 = int_y7;
                r_next14 = int_y2;
                r_next15 = int_y3;
            end
            2'b01: begin
                r_next1 = int_y2;
                r_next2 = int_y1;
                r_next3 = int_y3;
                r_next4 = int_y8;
                r_next5 = int_y10;
                r_next6 = int_y9;
                r_next7 = int_y11;
                r_next8 = int_y14;
                r_next9 = int_y12;
                r_next10 = int_y15;
                r_next11 = int_y13;
                r_next12 = int_y6;
                r_next13 = int_y4;
                r_next14 = int_y7;
                r_next15 = int_y5;
            end
            2'b10: begin
                r_next1 = int_y2;
                r_next2 = int_y4;
                r_next3 = int_y6;
                r_next4 = int_y1;
                r_next5 = int_y3;
                r_next6 = int_y5;
                r_next7 = int_y7;
                r_next8 = int_y14;
                r_next9 = int_y12;
                r_next10 = int_y10;
                r_next11 = int_y8;
                r_next12 = int_y15;
                r_next13 = int_y13;
                r_next14 = int_y11;
                r_next15 = int_y9;
            end
            2'b11: begin
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
            end
        endcase
    end

    always_comb begin
        unique case (state_reg)
            state0: begin
                s1 = 2'b00;
                state_next = (count_reg == 4'b0000) ? state1 : 
                                (count_reg == 4'b0010) ? state2 :
                                state3;
            end
            state1: begin
                s1 = 2'b01;
                state_next = state0;
            end
            state2: begin
                s1 = 2'b10;
                state_next = state1;
            end
            state3: begin
                s1 = 2'b11;
                state_next = state2;
            end
        endcase
    end
	 
	assign count_next = count_reg + 4'b0001;

endmodule
