module debouncer (
    input  wire clk,
    input  wire reset,
    input  wire sw,            
    output reg  db         
);

    
    localparam [2:0]
        zero     = 3'b000,
        wait1_1  = 3'b001,
        wait1_2  = 3'b010,
        wait1_3  = 3'b011,
        one      = 3'b100,
        wait0_1  = 3'b101,
        wait0_2  = 3'b110,
        wait0_3  = 3'b111;

    reg [2:0] present_state, next_state;

    reg [10:0] tick_counter;
    wire m_tick;
    
    always @(posedge clk or posedge reset) begin : State_Register
        if (reset) begin
            present_state <= zero;
            tick_counter <= 0;
        end else begin
            present_state <= next_state;
            if (tick_counter >= 9) begin
                tick_counter <= 0;
            end else begin
                tick_counter <= tick_counter + 1;
            end
        end
    end

    assign m_tick = (tick_counter == 9);


    always @(*) begin
        next_state = present_state; 
        case (present_state)
            zero: begin
                db = 1'b0;
                if (sw)
                    next_state = wait1_1;
            end
            wait1_1: begin
                db = 1'b0;
                if (!sw)
                    next_state = zero;
                else if (m_tick)
                    next_state = wait1_2;
            end
            wait1_2: begin
                db = 1'b0;
                if (!sw)
                    next_state = zero;
                else if (m_tick)
                    next_state = wait1_3;
            end
            wait1_3: begin
                db = 1'b0;
                if (!sw)
                    next_state = zero;
                else if (m_tick)
                    next_state = one;
            end
            //////////////////////////
            one: begin
                db = 1'b1;
                if (!sw)
                    next_state = wait0_1;
            end
            
            wait0_1: begin
                db = 1'b1;
                if (sw)
                    next_state = one;
                else if (m_tick)
                    next_state = wait0_2;
            end
            
            wait0_2: begin
                db = 1'b1;
                if (sw)
                    next_state = one;
                else if (m_tick)
                    next_state = wait0_3;
            end

            wait0_3: begin
                db = 1'b1;
                if (sw)
                    next_state = one;
                else if (m_tick)
                    next_state = zero;
            end
            
            default: next_state = zero;
        endcase
    end
endmodule