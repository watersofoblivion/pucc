module VerilatorFixtures (
  input logic clk,
  output logic[7:0] count,

  input logic sync_rst,
  output logic[7:0] sync_count,

  input logic async_rst,
  output logic[7:0] async_count,

  input logic input_signal,
  output logic output_signal,

  input logic[3:0] xsmall_input_bus,
  output logic[3:0] xsmall_output_bus,

  input logic[11:0] small_input_bus,
  output logic[11:0] small_output_bus,

  input logic[23:0] medium_input_bus,
  output logic[23:0] medium_output_bus,

  input logic[47:0] large_input_bus,
  output logic[47:0] large_output_bus,

  input logic[95:0] xlarge_input_bus,
  output logic[95:0] xlarge_output_bus,

  input logic[31:0] lhs,
  input logic[31:0] rhs,
  output logic[31:0] sum,

  output logic finalized
);

  // Signal Tests
  assign output_signal     = input_signal;
  assign xsmall_output_bus = xsmall_input_bus;
  assign small_output_bus  = small_input_bus;
  assign medium_output_bus = medium_input_bus;
  assign large_output_bus  = large_input_bus;
  assign xlarge_output_bus = xlarge_input_bus;

  // Unclocked Evaluation Test
  assign sum = lhs + rhs;

  // Finalization test
  assign finalized = 0;
  final finalized = 1;

  // Cycle Count
  initial count = 1;
  always_ff @(posedge clk) begin
    count <= count + 1;
  end

  // Synchronous Reset
  initial sync_count = 1;
  always_ff @(posedge clk) begin
    if (sync_rst) begin
      sync_count <= 1;
    end else begin
      sync_count <= sync_count + 1;
    end
  end

  // Asynchronous Reset (Positive Edge)
  initial async_count = 1;
  always_ff @(posedge clk or posedge async_rst) begin
    if (async_rst) begin
      async_count <= 1;
    end else begin
      async_count <= async_count + 1;
    end
  end
endmodule;
