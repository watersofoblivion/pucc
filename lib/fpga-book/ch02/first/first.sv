module first(
    input clk,
    input rst,
    output reg [7:0] led);

    initial begin
        led = 8'b0;
    end

    always_ff begin
        led[0] <= ~rst;
    end
endmodule
