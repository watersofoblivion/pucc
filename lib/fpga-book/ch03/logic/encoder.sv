module n_encoder #(parameter WIDTH = 1) (input [(1 << WIDTH) - 1:0] in, output [WIDTH - 1:0] out);
    genvar i;
    for (i = 0; i < WIDTH; i++) begin
        if (in[i] == 1'b1) begin
            assign out = i;
        end
    end
endmodule

module encoder(input [15:0] io_dip, output [19:0] io_led);
    n_encoder #(4) encoder(io_dip, io_led[19:16]);
    assign io_led[15:0] = io_dip;
endmodule