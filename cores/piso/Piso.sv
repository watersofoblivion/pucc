/**
 * Parallel-In, Serial-Out buffer
 */

module Piso (clk, rst, input_valid, input_data, input_ready, output_valid, output_bit, output_ready);
  // Data Size
  parameter DATA_BITS = 8;

  // Present Mask
  localparam EMPTY = DATA_BITS'('b0);
  localparam PRESENT = DATA_BITS'('b1);

  // Clock and Reset
  input logic clk;
  input logic rst;

  // Data Input
  input logic input_valid;
  input logic [DATA_BITS-1:0] input_data;
  output logic input_ready;

  // Data Output
  output logic output_valid;
  output logic output_bit;
  input logic output_ready;

  // Internal state
  logic [DATA_BITS-1:0] buffer;
  logic [DATA_BITS-1:0] present;

  assign input_ready = (!present[0]);
  assign output_valid = (present[0]);

  always_ff @(posedge clk) begin
    // Reset
    if (rst) begin
      buffer <= EMPTY;
      present <= EMPTY;
    end
  end
endmodule;
