module Transmitter(
    input clk, rst,
    input wr_en,
    input en, 
    input [7:0] data_in,
    output reg tx, busy
    );
    
    logic [7:0] data;
    logic [2:0] index;
    
    typedef enum logic [2:0] {IDLE, START, DATA, STOP} state_e;
    state_e ps;

    always @(posedge clk) begin
        if (rst) begin
            ps <= IDLE;
            tx <= 1'b1; // Idle state must be 1
            index <= 0;
        end else begin
            case (ps)
                IDLE: begin
                    tx <= 1'b1;
                    if (wr_en) begin
                        data <= data_in;
                        ps <= START;
                    end
                end
                START: if (en) begin
                    tx <= 1'b0; // Start bit
                    ps <= DATA;
                    index <= 0;
                end
                DATA: if (en) begin
                    tx <= data[index];
                    if (index == 7) ps <= STOP;
                    else index <= index + 1;
                end
                STOP: if (en) begin
                    tx <= 1'b1; // Stop bit
                    ps <= IDLE;
                end
                default: ps <= IDLE;
            endcase
        end
    end
    assign busy = (ps != IDLE);
endmodule