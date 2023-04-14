/*
 * A UART Transmitter
 */

module UartTx8n1 (clk, rst, tx, valid, data, ready);
  /*
   * Configuration
   */

  // Parameters
  parameter CLOCK_RATE_HZ = 100_000_000;
  parameter BAUD_RATE = 9_600;
 
  // Useful Constants
  localparam DATA_BITS = 8;
  localparam STOP_BITS = 1;
  localparam CLOCKS_PER_TICK = CLOCK_RATE_HZ / BAUD_RATE / 2;
  localparam SYNC_TICKS = 3;
  localparam BIT_TICKS = 2;

  /*
   * Ports
   */

  // Clock and Reset
  input logic clock;
  input logic reset;

  // Handshaking
  input logic valid;
  output logic ready;
  input logic[7:0] data;

  // Data
  output logic tx;

  /*
   * Implementation
   */

  // States
  enum {
    IDLE
  } state_t;

  // Internal state
  state_t state;
  logic busy;

  // Reset
  always_comb begin
    if (reset) begin
      ready <= 0;
      tx <= 1;
      state <= IDLE;
      busy <= 0;
    end
  end

  // State machine
  always_ff @(posedge clock) begin
    case (state) 
      IDLE: begin
        if (valid && !busy) begin

          state <= 
        end
      end;
    endcase
  end
endmodule;