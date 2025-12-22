`timescale 1ns / 1ps

// Testbench for ALU Module
// Tests all 10 operations with various test cases

module alu_tb;

    // Testbench signals
    logic [31:0] A, B;
    logic [3:0]  ALU_sel;
    logic [31:0] y;
    logic z;
    
    // Expected values
    logic [31:0] expected_y;
    logic expected_z;
    
    // Error counter
    int error_count = 0;
    int test_count = 0;
    
    // Instantiate ALU
    alu dut (
        .A(A),
        .B(B),
        .ALU_sel(ALU_sel),
        .y(y),
        .z(z)
    );
    
    // Test task
    task test_operation(
        input [3:0] sel,
        input [31:0] in_a,
        input [31:0] in_b,
        input [31:0] exp_y,
        input exp_zero
    );
        begin
            test_count++;
            A = in_a;
            B = in_b;
            ALU_sel = sel;
            expected_y = exp_y;
            expected_z = exp_zero;
            
            #10; // Wait for propagation
            
            if (y !== expected_y || z !== expected_z) begin
                error_count++;
                $display("ERROR: Test %0d FAILED", test_count);
                $display("  Operation: %b, A: %h, B: %h", ALU_sel, A, B);
                $display("  Expected: y=%h, z=%b", expected_y, expected_z);
                $display("  Got:      y=%h, z=%b", y, z);
            end else begin
                $display("PASS: Test %0d - Operation %b, A=%h, B=%h, y=%h, z=%b", 
                         test_count, ALU_sel, A, B, y, z);
            end
        end
    endtask
    
    // Main test sequence
    initial begin
        $display("========================================");
        $display("ALU Testbench Starting");
        $display("========================================\n");
        
        // ========== ADD (0000) Tests ==========
        $display("--- Testing ADD (0000) ---");
        test_operation(4'b0000, 32'h00000000, 32'h00000000, 32'h00000000, 1'b1);  // 0 + 0 = 0
        test_operation(4'b0000, 32'h00000005, 32'h00000003, 32'h00000008, 1'b0);  // 5 + 3 = 8
        test_operation(4'b0000, 32'hFFFFFFFF, 32'h00000001, 32'h00000000, 1'b1);  // -1 + 1 = 0 (wrap)
        test_operation(4'b0000, 32'h7FFFFFFF, 32'h00000001, 32'h80000000, 1'b0);  // Max + 1 = Min (overflow)
        test_operation(4'b0000, 32'h12345678, 32'h9ABCDEF0, 32'hACF13568, 1'b0);  // Random
        
        // ========== SUB (0001) Tests ==========
        $display("\n--- Testing SUB (0001) ---");
        test_operation(4'b0001, 32'h00000000, 32'h00000000, 32'h00000000, 1'b1);  // 0 - 0 = 0
        test_operation(4'b0001, 32'h00000008, 32'h00000003, 32'h00000005, 1'b0);  // 8 - 3 = 5
        test_operation(4'b0001, 32'h00000005, 32'h00000008, 32'hFFFFFFFD, 1'b0);  // 5 - 8 = -3
        test_operation(4'b0001, 32'h80000000, 32'h00000001, 32'h7FFFFFFF, 1'b0);  // Min - 1 = Max (underflow)
        test_operation(4'b0001, 32'h00000001, 32'h00000001, 32'h00000000, 1'b1);  // 1 - 1 = 0
        
        // ========== SLL (0010) Tests ==========
        $display("\n--- Testing SLL (0010) ---");
        test_operation(4'b0010, 32'h00000001, 32'h00000001, 32'h00000002, 1'b0);  // 1 << 1 = 2
        test_operation(4'b0010, 32'h00000001, 32'h00000008, 32'h00000100, 1'b0);  // 1 << 8 = 256
        test_operation(4'b0010, 32'h00000001, 32'h0000001F, 32'h80000000, 1'b0);  // 1 << 31 = 0x80000000
        test_operation(4'b0010, 32'hFFFFFFFF, 32'h00000001, 32'hFFFFFFFE, 1'b0);  // -1 << 1
        test_operation(4'b0010, 32'h12345678, 32'h00000004, 32'h23456780, 1'b0);  // Shift by 4
        test_operation(4'b0010, 32'h00000001, 32'h00000020, 32'h00000001, 1'b0);  // Shift by 32 (mod 32 = 0)
        test_operation(4'b0010, 32'h00000000, 32'h00000010, 32'h00000000, 1'b1);  // 0 << anything = 0
        
        // ========== XOR (0011) Tests ==========
        $display("\n--- Testing XOR (0011) ---");
        test_operation(4'b0011, 32'h00000000, 32'h00000000, 32'h00000000, 1'b1);  // 0 XOR 0 = 0
        test_operation(4'b0011, 32'hFFFFFFFF, 32'hFFFFFFFF, 32'h00000000, 1'b1);  // -1 XOR -1 = 0
        test_operation(4'b0011, 32'h55555555, 32'hAAAAAAAA, 32'hFFFFFFFF, 1'b0);  // Pattern test
        test_operation(4'b0011, 32'h12345678, 32'h12345678, 32'h00000000, 1'b1);  // Same value XOR = 0
        test_operation(4'b0011, 32'hF0F0F0F0, 32'h0F0F0F0F, 32'hFFFFFFFF, 1'b0);
        
        // ========== SRL (0100) Tests ==========
        $display("\n--- Testing SRL (0100) ---");
        test_operation(4'b0100, 32'h80000000, 32'h00000001, 32'h40000000, 1'b0);  // Logical shift right
        test_operation(4'b0100, 32'h80000000, 32'h0000001F, 32'h00000001, 1'b0);  // Shift by 31
        test_operation(4'b0100, 32'hFFFFFFFF, 32'h00000001, 32'h7FFFFFFF, 1'b0);  // -1 >> 1 (logical)
        test_operation(4'b0100, 32'h00000100, 32'h00000008, 32'h00000001, 1'b0);  // 256 >> 8 = 1
        test_operation(4'b0100, 32'h12345678, 32'h00000004, 32'h01234567, 1'b0);  // Shift by 4
        test_operation(4'b0100, 32'h00000000, 32'h00000010, 32'h00000000, 1'b1);  // 0 >> anything = 0
        
        // ========== SRA (0101) Tests ==========
        $display("\n--- Testing SRA (0101) ---");
        test_operation(4'b0101, 32'h80000000, 32'h00000001, 32'hC0000000, 1'b0);  // Arithmetic shift right (sign extend)
        test_operation(4'b0101, 32'h80000000, 32'h0000001F, 32'hFFFFFFFF, 1'b0);  // -2^31 >> 31 = -1
        test_operation(4'b0101, 32'hFFFFFFFF, 32'h00000001, 32'hFFFFFFFF, 1'b0);  // -1 >> 1 = -1 (arithmetic)
        test_operation(4'b0101, 32'h40000000, 32'h00000001, 32'h20000000, 1'b0);  // Positive number
        test_operation(4'b0101, 32'h12345678, 32'h00000004, 32'h01234567, 1'b0);  // Positive shift
        test_operation(4'b0101, 32'hFEDCBA98, 32'h00000004, 32'hFFEDCBA9, 1'b0);  // Negative number shift
        
        // ========== OR (0110) Tests ==========
        $display("\n--- Testing OR (0110) ---");
        test_operation(4'b0110, 32'h00000000, 32'h00000000, 32'h00000000, 1'b1);  // 0 OR 0 = 0
        test_operation(4'b0110, 32'hFFFFFFFF, 32'h00000000, 32'hFFFFFFFF, 1'b0);  // -1 OR 0 = -1
        test_operation(4'b0110, 32'h00000000, 32'hFFFFFFFF, 32'hFFFFFFFF, 1'b0);  // 0 OR -1 = -1
        test_operation(4'b0110, 32'h55555555, 32'hAAAAAAAA, 32'hFFFFFFFF, 1'b0);  // Pattern test
        test_operation(4'b0110, 32'h12345678, 32'h87654321, 32'h97755779, 1'b0);
        
        // ========== AND (0111) Tests ==========
        $display("\n--- Testing AND (0111) ---");
        test_operation(4'b0111, 32'h00000000, 32'hFFFFFFFF, 32'h00000000, 1'b1);  // 0 AND -1 = 0
        test_operation(4'b0111, 32'hFFFFFFFF, 32'hFFFFFFFF, 32'hFFFFFFFF, 1'b0);  // -1 AND -1 = -1
        test_operation(4'b0111, 32'h55555555, 32'hAAAAAAAA, 32'h00000000, 1'b1);  // Pattern test
        test_operation(4'b0111, 32'h12345678, 32'h0000FFFF, 32'h00005678, 1'b0);  // Mask test
        test_operation(4'b0111, 32'hFFFFFFFF, 32'h00000000, 32'h00000000, 1'b1);  // -1 AND 0 = 0
        
        // ========== SLT (1000) Tests - Signed ==========
        $display("\n--- Testing SLT (1000) - Signed ---");
        test_operation(4'b1000, 32'h00000005, 32'h00000008, 32'h00000001, 1'b0);  // 5 < 8 = 1
        test_operation(4'b1000, 32'h00000008, 32'h00000005, 32'h00000000, 1'b1);  // 8 < 5 = 0
        test_operation(4'b1000, 32'h00000005, 32'h00000005, 32'h00000000, 1'b1);  // 5 < 5 = 0
        test_operation(4'b1000, 32'hFFFFFFFF, 32'h00000000, 32'h00000001, 1'b0);  // -1 < 0 = 1
        test_operation(4'b1000, 32'h00000000, 32'hFFFFFFFF, 32'h00000000, 1'b1);  // 0 < -1 = 0
        test_operation(4'b1000, 32'h80000000, 32'h7FFFFFFF, 32'h00000001, 1'b0);  // Min < Max = 1
        test_operation(4'b1000, 32'h7FFFFFFF, 32'h80000000, 32'h00000000, 1'b1);  // Max < Min = 0
        
        // ========== SLTU (1001) Tests - Unsigned ==========
        $display("\n--- Testing SLTU (1001) - Unsigned ---");
        test_operation(4'b1001, 32'h00000005, 32'h00000008, 32'h00000001, 1'b0);  // 5 < 8 = 1
        test_operation(4'b1001, 32'h00000008, 32'h00000005, 32'h00000000, 1'b1);  // 8 < 5 = 0
        test_operation(4'b1001, 32'h00000005, 32'h00000005, 32'h00000000, 1'b1);  // 5 < 5 = 0
        test_operation(4'b1001, 32'hFFFFFFFF, 32'h00000000, 32'h00000000, 1'b1);  // 2^32-1 < 0 = 0 (unsigned)
        test_operation(4'b1001, 32'h00000000, 32'hFFFFFFFF, 32'h00000001, 1'b0);  // 0 < 2^32-1 = 1 (unsigned)
        test_operation(4'b1001, 32'h80000000, 32'h7FFFFFFF, 32'h00000000, 1'b1);  // 2^31 < 2^31-1 = 0 (unsigned)
        test_operation(4'b1001, 32'h7FFFFFFF, 32'h80000000, 32'h00000001, 1'b0);  // 2^31-1 < 2^31 = 1 (unsigned)
        
        // ========== Default case tests ==========
        $display("\n--- Testing Default Cases (1010-1111) ---");
        test_operation(4'b1010, 32'h12345678, 32'h9ABCDEF0, 32'h00000000, 1'b1);  // Should default to 0
        test_operation(4'b1111, 32'hFFFFFFFF, 32'hFFFFFFFF, 32'h00000000, 1'b1);  // Should default to 0
        
        // ========== Zero flag edge cases ==========
        $display("\n--- Testing Zero Flag Edge Cases ---");
        test_operation(4'b0000, 32'h80000000, 32'h80000000, 32'h00000000, 1'b1);  // -2^31 + -2^31 = 0 (wraps)
        test_operation(4'b0001, 32'h00000005, 32'h00000005, 32'h00000000, 1'b1);  // 5 - 5 = 0
        
        // Final summary
        #10;
        $display("\n========================================");
        $display("Test Summary");
        $display("========================================");
        $display("Total Tests: %0d", test_count);
        $display("Passed: %0d", test_count - error_count);
        $display("Failed: %0d", error_count);
        if (error_count == 0) begin
            $display("*** ALL TESTS PASSED! ***");
        end else begin
            $display("*** SOME TESTS FAILED! ***");
        end
        $display("========================================\n");
        
        $finish;
    end

endmodule

