/**
 * Parallel-In, Serial-Out buffer
 */

module Piso (clk, rst, input_valid, input_data, input_ready, output_valid, output_bit, output_ready);
  /*
   * Configuration
   */

  // Data Size
  parameter DATA_BITS = 8;

  // Useful Constants
  localparam EMPTY = DATA_BITS'('b0);
  localparam PRESENT = DATA_BITS'('b1);

  /*
   * Ports
   */

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

  /*
   * Implementation
   */

  // Internal state
  logic [DATA_BITS-1:0] buffer;
  logic [DATA_BITS-1:0] present;
  logic load_enable;
  logic unload_enable;

  // Input Handshake
  assign input_ready = !present[0];
  assign load_enable = input_valid & input_ready;

  // Output Handshake
  assign output_valid = present[0];
  assign output_bit = buffer[0];
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
      buffer <= input_data;
      present <= PRESENT;
    end
  end

  // Unload
  always_ff @(posedge clk) begin
    if (unload_enable) begin
      for (int i = 0; i < DATA_BITS - 1; i++) begin
        buffer[i] <= buffer[i + 1];
        present[i] <= present[i + 1];
      end

      present[DATA_BITS - 1] <= 0;
    end
  end
endmodule;
