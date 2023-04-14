/*
 * A UART
 */

module Uart8n1 (clk, rst, tx, rx, tx_valid, tx_data, tx_ready, rx_valid, tx_data, tx_ready);
  /*
   * Configuration
   */

  // Parameters
  parameter CLOCK_RATE_HZ = 100_000_000;
  parameter BAUD_RATE = 9_600;

  // Useful Constants
  localparam DATA_BITS = 8;

  /*
   * Ports
   */

  // Clock and Reset
  input logic clk;
  input logic rst;

  // Signal Wires
  input logic rx;
  output logic tx;

  // Transmit
  input logic tx_valid;
  input logic [DATA_BITS-1:0] tx_data;
  output logic tx_ready;

  // Receive
  output logic rx_valid;
  output logic [DATA_BITS-1:0] rx_data;
  input logic rx_ready;

  /*
   * Implementation
   */

  UartTx8n1 tx #(.CLOCK_RATE_HZ(CLOCK_RATE_HZ), .BAUD_RATE(BAUD_RATE)) (.clk(clk), .rst(rst), .tx(tx), .valid(tx_valid), .data(tx_data), .ready(tx_ready));
  UartRx8n1 rx #(.CLOCK_RATE_HZ(CLOCK_RATE_HZ), .BAUD_RATE(BAUD_RATE)) (.clk(clk), .rst(rst), .rx(rx), .valid(rx_valid), .data(rx_data), .ready(rx_ready));
endmodule;