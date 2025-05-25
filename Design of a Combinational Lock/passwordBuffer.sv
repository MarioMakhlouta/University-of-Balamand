module passwordBuffer (
    input logic clk,
    input logic rstN,
    input logic [3:0] data_in,     // 4-bit input character
    input logic [2:0] index,       // Index of the character position (0 to 7)
    input logic write_en,          // Write enable for the indexed position
    input logic clear_all,         // Clears the full register
    output logic [31:0] buffer_out // 8 x 4-bit characters in one register
);

    always_ff @(posedge clk, negedge rstN) begin
        if (!rstN)
				buffer_out <= 32'd0;
		  else if (clear_all) 
            buffer_out <= 32'd0;
        else if (write_en) begin
            case (index)
                3'd0: buffer_out[3:0]    <= data_in;
                3'd1: buffer_out[7:4]    <= data_in;
                3'd2: buffer_out[11:8]   <= data_in;
                3'd3: buffer_out[15:12]  <= data_in;
                3'd4: buffer_out[19:16]  <= data_in;
                3'd5: buffer_out[23:20]  <= data_in;
                3'd6: buffer_out[27:24]  <= data_in;
                3'd7: buffer_out[31:28]  <= data_in;
                default: buffer_out <= buffer_out;
            endcase
        end
    end

endmodule