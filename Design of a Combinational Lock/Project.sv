module Project (
input logic clk, rstN, 
inout wire [3:0] col, row, 
output logic [3:0] FinalChar,
output logic correct_password,  
output logic wrong_password,     
output wire backspace_flag,    
output wire locked_flag,
output logic keyFlag
);

// Internal signals
logic tick_20ms;
wire clear_all, write_en;
logic [3:0] char, data_out;
logic [2:0] index;
logic [31:0] buffer_out;

// Clock divider for 20ms tick
clockDivider c1(
  .clk(clk),
  .rstN(rstN), 
  .tick_20ms(tick_20ms)
);

// Keypad decoder (char is now 4 bits)
KeyPad c2(
  .col(col),
  .row(row),
  .clk(tick_20ms),
  .rstN(rstN),
  .char(char),
  .keyFlag(keyFlag)
);

assign FinalChar = char;

// Controller FSM (char is 4-bit now)
keypadController ctrl(
  .clk(tick_20ms),
  .rstN(rstN),
  .char(char),
  .data_out(data_out),
  .index(index),
  .write_en(write_en),
  .clear_all(clear_all),
  .write_en_debug(),
  .locked(locked_flag),
  .backspace_flag(backspace_flag)
);

// Password buffer
passwordBuffer c3(
  .clk(tick_20ms), 
  .rstN(rstN), 
  .data_in(data_out), 
  .index(index),
  .write_en(write_en),
  .clear_all(clear_all),
  .buffer_out(buffer_out)
);

// Password verification
assign correct_password = (buffer_out == 32'h0123);
assign wrong_password = (buffer_out != 32'h0123) && locked_flag;
assign locked_flag = locked_flag;
assign backspace_flag = backspace_flag;


endmodule 