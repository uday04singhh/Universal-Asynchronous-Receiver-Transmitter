module UART_top(
    input rst, 
    input [7:0] data_in, 
    input wr_en, clk, 
    input rdy_clr, 
    output rdy, busy, 
    output [7:0] data_out
);
    logic rx_en, tx_en, serial_line;

    Baud_Rate_Generator bg (
        .clk(clk), 
        .tx_en(tx_en), 
        .rx_en(rx_en)
    );

    Transmitter trans (
        .clk(clk),
        .rst(rst),
        .wr_en(wr_en),
        .en(tx_en),
        .data_in(data_in),
        .tx(serial_line),
        .busy(busy)
    );

    Receiver rec (
        .clk(clk),
        .rst(rst),
        .rx(serial_line),
        .rdy_clr(rdy_clr),
        .clk_en(rx_en),
        .rdy(rdy),
        .data_out(data_out)
    );
endmodule