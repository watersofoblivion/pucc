module io_and(input [15:0] io_dip, output [23:0] io_led);
    io io(io_dip[15:0], io_led[15:0]);

    assign io_led[23:16] = io_dip[7:0] & io_dip[15:8];
endmodule
