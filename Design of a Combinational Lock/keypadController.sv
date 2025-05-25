module keypadController (
    input logic clk,
    input logic rstN,          
    input logic [3:0] char,      // 4-bit input character (not ASCII)
    output logic [3:0] data_out,     // 4-bit digit to write into buffer
    output logic [2:0] index,        // Which 4-bit segment in 32-bit buffer
    output logic write_en,           // Enable writing to the buffer
    output logic clear_all,   
    output logic write_en_debug,    // Debug signal to mirror write_en
    output logic locked,             // Lock input after '#' is pressed
    output logic backspace_flag      // Flag for backspace operation
);

    typedef enum logic [2:0] {
        IDLE,
        WAIT_INPUT,
        STORE,
        DELETE,
        CLEAR,
        LOCK
    } state_t;

    state_t state, next_state;
    logic [2:0] ptr;
    assign write_en_debug = write_en;

    // FSM: state register
    always_ff @(posedge clk, negedge rstN) begin
        if (!rstN)
            state <= IDLE;
        else
            state <= next_state;
    end

    // FSM: next state logic
    always_comb begin
        next_state = state;
        case (state)
            IDLE:
                next_state = WAIT_INPUT;
            WAIT_INPUT: begin
                if (char == 4'b1101) next_state = DELETE;        // D
                else if (char == 4'b1100) next_state = CLEAR;    // C
                else if (char == 4'b1111) next_state = LOCK;     // #
                else if (char <= 4'd9 && ptr < 8 && !locked)
                    next_state = STORE;
                else
                    next_state = WAIT_INPUT;
            end
            STORE:  next_state = WAIT_INPUT;
            DELETE: next_state = WAIT_INPUT;
            CLEAR:  next_state = WAIT_INPUT;
            LOCK:   next_state = LOCK;
        endcase
    end

    // FSM: output logic   

	 always_comb begin 
	         write_en = 0;
            clear_all = 0;
            backspace_flag = 0;
				data_out =4'b0;
				index=1'b0;
				ptr=1'b0;
				locked=1'b0;
            case (state)
                STORE: begin
                    data_out = char;      // char is already 4-bit binary digit
                    index = ptr;
                    write_en = 1;
                    ptr = ptr + 1;
                end
                DELETE: begin
                    if (ptr > 0) begin
                        ptr = ptr - 1;
                        index = ptr - 1;
                        data_out = 4'd0;   // Clear the last digit
                        write_en = 1;
                        backspace_flag = 1; // Activate backspace flag
                    end
                end
                CLEAR: begin
                    clear_all = 1;
                    ptr = 0;
                end
                LOCK: begin
                    locked = 1;
                end
            endcase
    end
endmodule 