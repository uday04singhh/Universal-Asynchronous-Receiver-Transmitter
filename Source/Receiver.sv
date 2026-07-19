module Receiver(
    input rst, clk, rx, rdy_clr, clk_en,
    output logic rdy, 
    output logic [7:0] data_out 
    );

    typedef enum logic [1:0] {IDLE, START_BIT, DATA_BITS, STOP_BIT} state_t;
    state_t state;
    logic [3:0] sample;
    logic [2:0] index;
    logic [7:0] temp_reg;

    always @(posedge clk) begin
        if (rst) begin
            state <= IDLE;
            rdy <= 0;
            sample <= 0;
            data_out <= 0;
        end else begin
            if (rdy_clr) rdy <= 0;
            
            if (clk_en) begin
                case (state)
                    IDLE: begin
                        sample <= 0;
                        if (rx == 0) state <= START_BIT; // Detected start bit
                    end
                    START_BIT: begin
                        if (sample == 7) begin // Middle of start bit
                            if (rx == 0) begin
                                sample <= 0;
                                state <= DATA_BITS;
                                index <= 0;
                            end else state <= IDLE; // False start
                        end else sample <= sample + 1;
                    end
                    DATA_BITS: begin
                        if (sample == 15) begin
                            sample <= 0;
                            if (index == 7) state <= STOP_BIT;
                            else index <= index + 1;
                        end else begin
                            if (sample == 7) temp_reg[index] <= rx; // Sample middle
                            sample <= sample + 1;
                        end
                    end
                    STOP_BIT: begin
                        if (sample == 15) begin
                            data_out <= temp_reg;
                            rdy <= 1;
                            state <= IDLE;
                        end else sample <= sample + 1;
                    end
                endcase
            end
        end
    end
endmodule