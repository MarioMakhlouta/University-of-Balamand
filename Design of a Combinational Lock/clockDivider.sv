module clockDivider (
    input logic clk,         
    input logic rstN,          
    output logic tick_20ms 
);
    
    logic [17:0] clk_div_counter;  
    logic clk_out;

    always_ff @(posedge clk or negedge rstN) begin
        if (!rstN) begin
            clk_div_counter <= 0;
        end 
        else if (clk_div_counter == 18'd249_999) begin  
            clk_div_counter <= 0;   
        end 
        else begin
            clk_div_counter <= clk_div_counter + 1;
        end
    end

    always_ff @(posedge clk, negedge rstN) begin
        if (!rstN) begin
            clk_out <= 0;
        end 
        else if (clk_div_counter < 18'd125_000) begin
            clk_out <= 1;
        end 
        else begin
            clk_out <= 0;
        end
    end

    // Final clock output (clk_out_final follows clk_out)
    always_ff @(posedge clk or negedge rstN) begin
        if (!rstN)
            tick_20ms <= 0;
        else
            tick_20ms <= clk_out;
    end
endmodule 