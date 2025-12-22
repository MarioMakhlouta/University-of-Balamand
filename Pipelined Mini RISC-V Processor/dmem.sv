// data memory - handles load/store operations

module dmem (
    input logic clk,
    input logic reset,
    input logic [31:0] addr,
    input logic [31:0] write_data,
    input logic mem_read,
    input logic mem_write,
    output logic [31:0] read_data
);

    logic [31:0] memory [0:1023];
    
    // init memory for testing
    initial begin
        for (int i = 0; i < 1024; i++) begin
            memory[i] = 32'(i + 1);
        end
    end
    
    always_ff @(posedge clk) begin
        if (reset) begin
            for (int i = 0; i < 1024; i++) begin
                 memory[i] <= 32'd0;
            end
        end else begin
            if (mem_write) begin
                memory[addr[11:2]] <= write_data;
            end
        end
    end
    
    always_ff @(posedge clk) begin
        if (mem_read) begin
            read_data <= memory[addr[11:2]];
        end else begin
            read_data <= 32'd0;
        end
    end

endmodule

