/*
 * A UART Receiver
 */

module UartRx8n1 (clk, rst, rx, valid, data, ready);
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
  input logic clk;
  input locic rst;

  // Serial Data
  input logic rx;

  // Received data
  output logic valid;
  output logic [DATA_BITS-1:0] data;

  // Consumer
  input logic ready;

  /*
   * Implementation
   */

  // States
  enum {IDLE, SYNC, RX, STOP, VALID} state_t;

  // Internal state
  state_t state;
  logic[7:0] buffer;
  int countdown;
  int tick;
  int wait_ticks;
  int bits;

  // Transmit the contents of the buffer
  assign data = buffer;

  // Reset
  always_comb begin
    if (reset) begin: reset
      buffer <= 0;
      state <= IDLE;
      valid <= 0;
    end: reset
  end

  // Ticks
  always_ff @(posedge clk) begin
    if (state == IDLE) begin: wait_for_sync
      if (!rx) begin: sync_begin
        state <= SYNC;
        wait_ticks <= 2;
        tick <= 0;
        countdown <= CLOCKS_PER_TICK;
      end
    end else begin: ticking
      if (countdown == 0) begin: tick
        tick <= 1;
        countdown <= CLOCKS_PER_TICK;
      end else begin: wait_for_tick
        tick <= 0;
        countdown <= countdown - 1;
      end
    end
  end

  // State Machine
  always_ff @(posedge tick) begin
    case (state)
      IDLE: begin
        // Can't happen
      end
      SYNC: begin
        if (rx) begin: spurious_sync
          state <= IDLE;
        end else begin: syncing
          if (wait_ticks == 0) begin: sync_complete
            state <= RX;
            bits <= DATA_BITS - 1;
          end else begin: sync_wait
            wait_ticks <= wait_ticks - 1;
          end
        end
      end
      RX: begin
        if (wait_ticks == 0) begin: read_bit
          generate
            for (i = 0; i < DATA_BITS - 1; i++) begin
              buffer[i+1] <= buffer[i];
              buffer[0] <= rx;
            end
          endgenerate

          if (bits == 0) begin: last_bit
            state <= VALID;
            valid <= 1;
          end

          wait_ticks <= 1;
        end else begin: wait_for_bit
          wait_ticks <= 0;
        end
      end
      STOP: begin
        state <= VALID;
      end
      VALID: begin
        state <= IDLE;
      end
    endcase
  end
endmodule;