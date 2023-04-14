/**
 * Serial-In, Parallel-Out buffer
 */

 module Sipo (clk, rst, input_valid, input_bit, input_ready, output_valid, output_data, output_ready);
  /*
   * Configuration
   */

  // Data Size
  parameter DATA_BITS = 8;

  // Useful Constants
  localparam EMPTY = DATA_BITS'('b0);

  /*
   * Parameters
   */

  // Clock and Reset
  input logic clk;
  input logic rst;

  // Data Input
  input logic input_valid;
  input logic input_bit;
  output logic input_ready;

  // Data Output
  output logic output_valid;
  output logic [DATA_BITS-1:0] output_data;
  input logic output_ready;

  /*
   * Implementation
   */

  // Internal state
  logic [DATA_BITS-1:0] buffer;
  logic [DATA_BITS-1:0] present;
  logic load_enable;
  logic unload_enable;

  // Input Handshake
  assign input_ready = !present[DATA_BITS - 1];
  assign load_enable = input_valid & input_ready;

  // Output Handshake
  assign output_valid = &present;
  assign output_data = buffer;
  assign unload_enable = output_valid & output_ready;

  // Reset
  always_ff @(posedge clk) begin
    if (rst) begin
      buffer <= EMPTY;
      present <= EMPTY;
    end
  end

  // Load
  always_ff @(posedge clk) begin
    if (load_enable) begin
      for (int i = 0; i < DATA_BITS - 1; i++) begin
        buffer[i + 1] <= buffer[i];
        present[i + 1] <= present[i];
      end

      buffer[0] <= input_bit;
      present[0] <= 1;
    end
  end

  // Unload
  always_ff @(posedge clk) begin
    if (unload_enable) begin
      buffer <= EMPTY;
      present <= EMPTY;
    end
  end
endmodule;
