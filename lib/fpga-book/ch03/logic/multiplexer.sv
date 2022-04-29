module n_multiplexer
    #(
        parameter INPUTS = 1
    )
    (
        input [INPUTS - 1:0] inputs,
        input [INPUTS - 1:0] selector,
        output out
    );

    wire [INPUTS - 1:0] tmp;

    genvar i;
    for (i = 0; i < INPUTS; i++) begin
        assign tmp[i] = inputs[i] & selector[i];
    end

    assign out = |tmp;
endmodule

module mn_multiplexer
    #(
        parameter WIDTH = 1,
        parameter INPUTS = 2
    )
    (
        input [WIDTH * INPUTS - 1:0] inputs,
        input [INPUTS - 1:0] selector,
        output [WIDTH - 1:0] out
    );

    wire [WIDTH:0] tmp;

    genvar i, j;
    for (i = 0; i < WIDTH; i++) begin
        wire [INPUTS - 1:0] tmp;
        for (j = 0; j < INPUTS; j++) begin
            assign tmp[j] = inputs[j * WIDTH + i];
        end

        n_multiplexer #(INPUTS) n_mux(tmp, selector, out[i]);
    end
endmodule

module multiplexer(input [19:0] io_dip, output [19:0] io_led);
    assign io_led[15:0] = io_dip[15:0];
    mn_multiplexer #(4, 4) mn_mux(io_dip[15:0], io_dip[19:16], io_led[19:16]);
endmodule
