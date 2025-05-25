module counter(input logic rstN,clk, output logic y);

logic [3:0] r_next, r_reg;

always_ff @(posedge clk, negedge rstN)
      if(!rstN)
				r_reg <= 4'b0000;
      else
				r_reg <= r_next;

always_comb begin
       r_next = r_reg + 4'b0001;
end

assign y = r_next;

endmodule 