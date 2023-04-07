/**
 * Subtraction Operation
 * ===
 *
 * An N-bit subtraction operation
 */

/*
 * Interface
 */

interface SubOp;
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
module SubOpNative(SubOp.Impl iface);
  assign iface.res = iface.lhs - iface.rhs;
endmodule;

/** Formal Verification Abstraction */
module SubOpAbstraction(SubOp.Impl iface);
  result: assume (iface.res == iface.lhs - iface.rhs);
endmodule;

/*
 * Testing
 */

/** Testing harness to wire inputs and outputs to an interface */
module SubOpHarness
  #(
    OPERAND_WIDTH
  )(
    input  logic[OPERAND_WIDTH-1:0] lhs,
    input  logic[OPERAND_WIDTH-1:0] rhs,
    output logic[OPERAND_WIDTH-1:0] res,
    SubOp.Injected                  dut
  );

  // Wire the inputs and outputs
  assign dut.lhs = lhs;
  assign dut.rhs = rhs;
  assign res = dut.res;
endmodule;

/** Top-level module for unit testing with Verilator */
module SubOpUnitTestVerilator
  #(
    OPERAND_WIDTH
  )(
    input  logic[OPERAND_WIDTH-1:0] lhs,
    input  logic[OPERAND_WIDTH-1:0] rhs,
    output logic[OPERAND_WIDTH-1:0] res
  );
  
  // Create the DUT
  SubOp iface;
  SubOpImpl dut(.iface(iface));

  // Wire the DUT up for testing
  SubOpHarness harness(.lhs(lhs), .rhs(rhs), .res(res), .dut(dut));
endmodule;

/** Top-level module for integration testing with Verilator */
module SubOpIntegrationTestVerilator
  #(
    OPERAND_WIDTH
  )(
    input  logic[OPERAND_WIDTH-1:0] lhs,
    input  logic[OPERAND_WIDTH-1:0] rhs,
    output logic[OPERAND_WIDTH-1:0] res
  );

  // Create the DUT
  SubOp iface;
  SubOpImpl dut(.iface(iface));

  // Wire the DUT up for testing
  SubOpHarness harness(.lhs(lhs), .rhs(rhs), .res(res), .dut(dut));
endmodule;

/** Top-level module for unit testing on a device */
module SubOpUnitTestDevice
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
module SubOpIntegrationTestDevice
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