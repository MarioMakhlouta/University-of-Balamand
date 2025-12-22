// instruction memory - stores program instructions

module imem (
    input logic clk,
    input logic [31:0] addr,
    output logic [31:0] instruction
);

    logic [31:0] memory [0:1023];
    
    initial begin
        // fill with NOPs all IM initially
        for (int i = 0; i < 1024; i++) begin
            memory[i] = 32'h00000013;
        end
        
        // test program for pipeline
        // reg file starts with x1=1, x2=2, etc
        // data mem starts with mem[0]=1, mem[1]=2, etc
        
//        // basic ADDI tests
//        memory[0] = 32'h00100093;   // ADDI x1, x0, 1        : x1 = 0 + 1 = 1 (overwrite initial x1=1)
//        memory[1] = 32'h00200113;   // ADDI x2, x0, 2        : x2 = 0 + 2 = 2 (overwrite initial x2=2)
//        memory[2] = 32'h00300193;   // ADDI x3, x0, 3        : x3 = 0 + 3 = 3 (overwrite initial x3=3)
//        memory[3] = 32'h00400213;   // ADDI x4, x0, 4        : x4 = 0 + 4 = 4 (overwrite initial x4=4)
//        
//        // forwarding tests
//        // case 1: back-to-back instructions using same register
//        memory[4] = 32'h002082B3;   // ADD x5, x1, x2        : x5 = x1 + x2 = 1 + 2 = 3
//        memory[5] = 32'h40528333;   // SUB x6, x5, x5        : x6 = x5 - x5 = 0 (FORWARDING: x5 from MEM)
//        
//        // case 2: one instruction gap
//        memory[6] = 32'h003083B3;   // ADD x7, x1, x3        : x7 = x1 + x3 = 1 + 3 = 4
//        memory[7] = 32'h00400413;   // ADDI x8, x0, 4        : x8 = 0 + 4 = 4 (delay instruction)
//        memory[8] = 32'h007484B3;   // ADD x9, x9, x7        : x9 = x9 + x7 (FORWARDING: x7 from WB)
//        
//        // case 3: both inputs need forwarding
//        memory[9] = 32'h00408533;   // ADD x10, x1, x4       : x10 = x1 + x4 = 1 + 4 = 5
//        memory[10] = 32'h005085B3;  // ADD x11, x1, x5       : x11 = x1 + x5 = 1 + 3 = 4
//        memory[11] = 32'h00A585B3;  // ADD x11, x11, x10     : x11 = x11 + x10 (FORWARDING: both from WB)
//        
//        // R-type instruction tests
//        memory[12] = 32'h00310633;  // ADD x12, x2, x3       : x12 = x2 + x3 = 2 + 3 = 5
//        memory[13] = 32'h40C106B3;  // SUB x13, x2, x12      : x13 = x2 - x12 = 2 - 5 = -3
//        memory[14] = 32'h00317733;  // AND x14, x2, x3       : x14 = x2 & x3 = 2 & 3 = 2
//        memory[15] = 32'h0031E733;  // OR x14, x3, x3        : x14 = x3 | x3 = 3 | 3 = 3
//        memory[16] = 32'h00314733;  // XOR x14, x2, x3       : x14 = x2 ^ x3 = 2 ^ 3 = 1
//        
//        // I-type logic instructions
//        memory[17] = 32'h00F0F013;  // ANDI x0, x1, 15       : x0 = x1 & 15 = 1 & 15 = 1 (x0 stays 0!)
//        memory[18] = 32'h00F0E113;  // ORI x2, x1, 15        : x2 = x1 | 15 = 1 | 15 = 15
//        memory[19] = 32'h00F14113;  // XORI x2, x2, 15       : x2 = x2 ^ 15 = 15 ^ 15 = 0
//        
//        // I-type shift instructions
//        memory[20] = 32'h00109093;  // SLLI x1, x1, 1        : x1 = x1 << 1 = 1 << 1 = 2
//        memory[21] = 32'h4010D093;  // SRLI x1, x1, 1        : x1 = x1 >> 1 = 2 >> 1 = 1 (logical)
//        memory[22] = 32'h40115093;  // SRAI x1, x1, 1        : x1 = x1 >>> 1 = 1 >>> 1 = 0 (arithmetic, x1 is positive)
//        
//        // R-type shift instructions
//        memory[23] = 32'h001191B3;  // SLL x3, x3, x1        : x3 = x3 << x1[4:0] = 3 << 1 = 6
//        memory[24] = 32'h0011D1B3;  // SRL x3, x3, x1        : x3 = x3 >> x1[4:0] = 6 >> 1 = 3 (logical)
//        memory[25] = 32'h4011D1B3;  // SRA x3, x3, x1        : x3 = x3 >>> x1[4:0] = 3 >>> 1 = 1 (arithmetic)
//        
//        // I-type comparison instructions
//        memory[26] = 32'h0030A013;  // SLTI x0, x1, 3        : x0 = (signed x1 < 3) ? 1 : 0 (x0 stays 0!)
//        memory[27] = 32'h0030A113;  // SLTI x2, x1, 3        : x2 = (signed x1 < 3) ? 1 : 0 = 1 (if x1 < 3)
//        memory[28] = 32'h0030B113;  // SLTIU x2, x1, 3       : x2 = (unsigned x1 < 3) ? 1 : 0 = 1 (if x1 < 3)
//        memory[29] = 32'h00A0A113;  // SLTI x2, x1, 10       : x2 = (signed x1 < 10) ? 1 : 0 = 1 (if x1 < 10)
//        
//        // R-type comparison instructions
//        memory[30] = 32'h0011A133;  // SLT x2, x3, x1        : x2 = (signed x3 < x1) ? 1 : 0 = (3 < 1) ? 1 : 0 = 0
//        memory[31] = 32'h0011B133;  // SLTU x2, x3, x1       : x2 = (unsigned x3 < x1) ? 1 : 0 = (3 < 1) ? 1 : 0 = 0
//        memory[32] = 32'h0031A1B3;  // SLT x3, x3, x3        : x3 = (signed x3 < x3) ? 1 : 0 = 0 (always false)
//        memory[33] = 32'h0021A2B3;  // SLT x5, x3, x2        : x5 = (signed x3 < x2) ? 1 : 0 = (3 < 0) ? 1 : 0 = 0
//        
//        // setup for memory tests
//        memory[34] = 32'h00000113;  // ADDI x2, x0, 0        : x2 = 0 (address for memory access, overwrites x2)
//        
//        // load-use hazard tests (HDU should stall these)
//        // case 1: LW then use result immediately
//        memory[35] = 32'h0000A083;  // LW x1, 0(x2)          : x1 = mem[x2+0] = mem[0] = 1 (load from memory)
//        memory[36] = 32'h001081B3;  // ADD x3, x1, x1        : x3 = x1 + x1 (HAZARD: needs x1, HDU stall 1 cycle)
//                                      // Expected: After stall, x3 = 1 + 1 = 2 (forwarding from WB)
//        
//        // case 2: LW then use in different register
//        memory[37] = 32'h0000A103;  // LW x2, 0(x2)          : x2 = mem[x2+0] = mem[0] = 1 (overwrites x2=0)
//        memory[38] = 32'h402106B3;  // SUB x13, x2, x2       : x13 = x2 - x2 (HAZARD: needs x2, HDU stall 1 cycle)
//                                      // Expected: After stall, x13 = 1 - 1 = 0 (forwarding from WB)
//        
//        // case 3: LW result used as rs2
//        memory[39] = 32'h00100113;  // ADDI x2, x0, 1        : x2 = 1 (setup address)
//        memory[40] = 32'h0000A203;  // LW x4, 0(x2)          : x4 = mem[x2+0] = mem[1] = 2
//        memory[41] = 32'h00418333;  // ADD x6, x3, x4        : x6 = x3 + x4 (HAZARD: needs x4, HDU stall 1 cycle)
//                                      // Expected: After stall, x6 = 2 + 2 = 4 (forwarding from WB, x3=2 from previous)
//        
//        // case 4: load followed by another load, then add
//        memory[42] = 32'h0000A283;  // LW x5, 0(x2)
//        memory[43] = 32'h0000A303;  // LW x6, 0(x2)
//        memory[44] = 32'h005304B3;  // ADD x9, x6, x5
//                                      // Expected: After stalls, x9 = 2 + 2 = 4 (x6 forwarded from WB, x5 forwarded from WB)
//        
//        // store instruction tests
//        memory[45] = 32'h00100213;  // ADDI x4, x0, 1        : x4 = 1 (setup for store)
//        memory[46] = 32'h00000113;  // ADDI x2, x0, 0        : x2 = 0 (setup address)
//        memory[47] = 32'h0040A023;  // SW x4, 0(x2)          : mem[x2+0] = mem[0] = x4 = 1 (store to memory)
//        memory[48] = 32'h0050A023;  // SW x5, 0(x2)          : mem[x2+0] = mem[0] = x5 = 2 (overwrite, x5=2 from previous)
//        
//        // branch instruction tests
//        memory[49] = 32'h00100093;  // ADDI x1, x0, 1        : x1 = 1
//        memory[50] = 32'h00100113;  // ADDI x2, x0, 1        : x2 = 1
//        memory[51] = 32'h00208663;  // BEQ x1, x2, 12        : if (x1 == x2) PC = PC + 12 (BRANCH TAKEN: x1==x2==1)
//        memory[52] = 32'h00300193;  // ADDI x3, x0, 3
//        memory[53] = 32'h00400213;  // ADDI x4, x0, 4
//        memory[54] = 32'h00500293;  // ADDI x5, x0, 5        : x5 = 5 (branch target)
//        
//        memory[55] = 32'h00100113;  // ADDI x2, x0, 1        : x2 = 1
//        memory[56] = 32'h00200193;  // ADDI x3, x0, 2        : x3 = 2
//        memory[57] = 32'h00309663;  // BNE x1, x3, 12        : if (x1 != x3) PC = PC + 12 (BRANCH TAKEN: x1=1 != x3=2)
//        memory[58] = 32'h00600313;  // ADDI x6, x0, 6
//        memory[59] = 32'h00700393;  // ADDI x7, x0, 7
//        memory[60] = 32'h00800413;  // ADDI x8, x0, 8        : x8 = 8 (branch target)
//        
//        // more forwarding tests
//        memory[61] = 32'h00108533;  // ADD x10, x1, x1        : x10 = x1 + x1 = 1 + 1 = 2
//        memory[62] = 32'h002085B3;  // ADD x11, x1, x2        : x11 = x1 + x2 = 1 + 1 = 2 (x2=1 from previous)
//        memory[63] = 32'h00A585B3;  // ADD x11, x11, x10      : x11 = x11 + x10 (FORWARDING: x11 from MEM, x10 from WB)
//        
        // rest of memory is NOPs
    end
    
    // can load from hex file if needed (another method to run program - from RARS software): 
    initial begin
        $readmemh("instr_mem.hex", memory);
    end
    
    always_ff @(posedge clk) begin
        instruction <= memory[addr[11:2]];
    end

endmodule

