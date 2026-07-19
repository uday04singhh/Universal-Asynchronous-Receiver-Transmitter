`timescale 1ns / 1ps

module UART_top_tb;

    logic clk = 0; // Initialize clock here
    logic rst;
    logic [7:0] data_in;
    logic wr_en = 0;
    logic rdy, rdy_clr = 0;
    logic [7:0] dout; 
    logic busy;

    // Use named mapping to ensure signals connect to the right ports
    UART_top dut (
        .rst(rst), 
        .data_in(data_in), 
        .wr_en(wr_en), 
        .clk(clk), 
        .rdy_clr(rdy_clr), 
        .rdy(rdy), 
        .busy(busy), 
        .data_out(dout)
    );

    // Clock generator
    always #5 clk = ~clk; 

    // Tasks
    task send_byte(input [7:0] din);
        begin 
            @(negedge clk);
            data_in = din;
            wr_en = 1'b1;
            @(negedge clk); 
            wr_en = 1'b0;
        end 
    endtask

    task clr_rdy;
        begin 
            @(negedge clk); 
            rdy_clr = 1'b1;
            @(negedge clk);
            rdy_clr = 1'b0;
        end 
    endtask 

    initial begin 
        // Initial Reset
        rst = 1'b1;
        #20;
        @(negedge clk);
        rst = 1'b0;
        #50;

        // Transaction 1
        send_byte(8'h41); 
        // Wait for the receiver to signal it has the data
        wait(rdy); 
        $display("At time %t: Received data is %h (Expected: 41)", $time, dout);
        clr_rdy;

        // Transaction 2
        send_byte(8'h55);
        wait(rdy);
        $display("At time %t: Received data is %h (Expected: 55)", $time, dout);
        clr_rdy;

        #1000; // Increased delay to see the final waveforms
        $finish; 
    end 

endmodule
