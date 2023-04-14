/*
 * A UART Transmitter
 */

module UartTx ();
  // Clock and Reset
  input logic clock;
  input logic reset;

  // Handshaking
  input logic valid;
  output logic ready;
  input logic[7:0] data;

  // Data
  output logic tx;

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