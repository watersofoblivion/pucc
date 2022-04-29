module n_decoder
    #(parameter WIDTH = 1)
     (input [WIDTH - 1:0] in, output [(1 << WIDTH) - 1:0] out);

    genvar i;
    for (i = 0; i < 1 << WIDTH; i++) begin
        assign out[i] = in == i;
    end
endmodule

module decoder(input [3:0] io_dip, output [23:0] io_led);
    assign io_led[3:0] = io_dip;
    n_decoder #(4) dec (io_dip, io_led[23:8]);
endmodule
