/**
 * OR operation
 * ===
 *
 * An N-bit OR operation
 */

/*
 * Interface
 */

interface OrOp;
  /*
   * Parameters
   */

  /// The bitwidth of the operands
  parameter OPERAND_WIDTH;

  /*
   * Signals
   */

  /// The operands
  logic [OPERAND_WIDTH-1:0] lhs;
  logic [OPERAND_WIDTH-1:0] rhs;

  /// The result
  logic [OPERAND_WIDTH-1:0] result;

  /*
   * Modports
   */
  
  /// The ports from the perspective of the implementation
  modport Impl (input lhs, rhs, output result);

  /// The ports when injected into a component
  modport Injected (output lhs, rhs, input result);
endinterface;

/*
 * Implementations
 */

/** Default SystemVerilog Implementation */
module OrOpNative(OrOp.Impl iface);
  assign iface.res = iface.lhs | iface.rhs;
endmodule;

/** Formal Verification Abstraction */
module OrOpAbstraction(OrOp.Impl iface);
  result: assume (iface.res == iface.lhs | iface.rhs);
endmodule;

/*
 * Testing
 */

/** Testing harness to wire inputs and outputs to an interface */
module OrOpHarness
  #(
    OPERAND_WIDTH
  )(
    input  logic[OPERAND_WIDTH-1:0] lhs,
    input  logic[OPERAND_WIDTH-1:0] rhs,
    output logic[OPERAND_WIDTH-1:0] res,
    OrOp.Injected                   dut
  );

  // Wire the inputs and outputs
  assign dut.lhs = lhs;
  assign dut.rhs = rhs;
  assign res = dut.res;
endmodule;

/** Top-level module for unit testing with Verilator */
module OrOpUnitTestVerilator
  #(
    OPERAND_WIDTH
  )(
    input  logic[OPERAND_WIDTH-1:0] lhs,
    input  logic[OPERAND_WIDTH-1:0] rhs,
    output logic[OPERAND_WIDTH-1:0] res
  );
  
  // Create the DUT
  OrOp iface;
  OrOpImpl dut(.iface(iface));

  // Wire the DUT up for testing
  OrOpHarness harness(.lhs(lhs), .rhs(rhs), .res(res), .dut(dut));
endmodule;

/** Top-level module for integration testing with Verilator */
module OrOpIntegrationTestVerilator
  #(
    OPERAND_WIDTH
  )(
    input  logic[OPERAND_WIDTH-1:0] lhs,
    input  logic[OPERAND_WIDTH-1:0] rhs,
    output logic[OPERAND_WIDTH-1:0] res
  );

  // Create the DUT
  OrOp iface;
  OrOpImpl dut(.iface(iface));

  // Wire the DUT up for testing
  OrOpHarness harness(.lhs(lhs), .rhs(rhs), .res(res), .dut(dut));
endmodule;

/** Top-level module for unit testing on a device */
module OrOpUnitTestDevice
  #(
    OPERAND_WIDTH
  )(
    input  logic clk,
    input  logic rst,
    input  logic uart_rx,
    output logic uart_tx,
  );
  
  // TODO
endmodule;

/** Top-level module for integration testing on a device */
module OrOpIntegrationTestDevice
  #(
    OPERAND_WIDTH
  )(
    input  logic clk,
    input  logic rst,
    input  logic uart_rx,
    output logic uart_tx,
  );

  // TODO
endmodule;