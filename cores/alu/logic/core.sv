/**
 * Logic Unit
 * ===
 *
 * The logic portion of the ALU
 */
interface LogicUnit;
  /*
   * Parameters
   */
  
  /// The bitwidth of the operands
  parameter OPERAND_WIDTH;

  /*
   * Signals
   */
  
  /// The operation
  logic [2:0] operation;

  /// The operands
  logic [OPERAND_WIDTH-1:0] lhs;
  logic [OPERAND_WIDTH-1:0] rhs;

  /// The result
  logic [OPERAND_WIDTH-1:0] result;

  /*
   * Modports
   */
  
  /// The interface from the perspective of the implemetation
  modport Impl (input operation, lhs, rhs, output result);

  /// The ports when injected into a component
  modport Injected (output operation, lhs, rhs, input result);
endinterface;

/*
 * Implementation
 */

module LogicUnitImpl(LogicUnit.Impl iface, AndOp.Injected and_op, OrOp.Injected or_op, XorOp.Injected xor_op);
endmodule;

module LogicUnitAbstraction(LogicUnit.Impl iface, AndOp.Injected and_op, OrOp.Injected or_op, XorOp.Injected xor_op);
endmodule;

/*
 * Testing
 */

/** Testing harness to wire inputs and outputs to an interface */
module LogicUnitHarness
  #(
    OPERAND_WIDTH
  )(
    input  logic[2:0]               op,
    input  logic[OPERAND_WIDTH-1:0] lhs,
    input  logic[OPERAND_WIDTH-1:0] rhs,
    output logic[OPERAND_WIDTH-1:0] res,
    LogicUnit.Injected              dut
  );

  // Wire the inputs and outputs
  assign dut.op  = op;
  assign dut.lhs = lhs;
  assign dut.rhs = rhs;
  assign res = dut.res;
endmodule;

/** Top-level module for unit testing with Verilator */
module LogicUnitUnitTestVerilator
  #(
    OPERAND_WIDTH
  )(
    // And Operation
    output logic[OPERAND_WIDTH-1:0] and_op_lhs;
    output logic[OPERAND_WIDTH-1:0] and_op_rhs;
    input  logic[OPERAND_WIDTH-1:0] and_op_res;

    // Or Operation
    output logic[OPERAND_WIDTH-1:0] or_op_lhs;
    output logic[OPERAND_WIDTH-1:0] or_op_rhs;
    input  logic[OPERAND_WIDTH-1:0] or_op_res;

    // Or Operation
    output logic[OPERAND_WIDTH-1:0] xor_op_lhs;
    output logic[OPERAND_WIDTH-1:0] xor_op_rhs;
    input  logic[OPERAND_WIDTH-1:0] xor_op_res;

    // Logic Unit
    input  logic[2:0]               op,
    input  logic[OPERAND_WIDTH-1:0] lhs,
    input  logic[OPERAND_WIDTH-1:0] rhs,
    output logic[OPERAND_WIDTH-1:0] res
  );

  // And Operation
  AndOp and_op;
  always_comb begin
    // Assign operands to outputs
    and_op_lhs = and_op.lhs;
    and_op_rhs = and_op.rhs;

    // Read result from inputs
    and_op.res = and_op_res;
  end

  // Or Operation
  OrOp or_op;
  always_comb begin
    // Assign operands to outputs
    or_op_lhs = or_op.lhs;
    or_op_rhs = or_op.rhs;

    // Read result from inputs
    or_op.res = or_op_res;
  end

  // Xor Operation
  XorOp xor_op;
  always_comb begin
    // Assign operands to outputs
    xor_op_lhs = xor_op.lhs;
    xor_op_rhs = xor_op.rhs;

    // Read result from inputs
    xor_op.res = xor_op_res;
  end
  
  // Create the DUT
  LogicUnit iface;
  LogicUnitImpl dut(.iface(iface), .and_op(and_op), .or_op(or_op), .xor_op(xor_op));

  // Wire the DUT up for testing
  LogicUnitHarness harness(.lhs(lhs), .rhs(rhs), .res(res), .dut(dut));
endmodule;

/** Top-level module for integration testing with Verilator */
module LogicUnitIntegrationTestVerilator
  #(
    OPERAND_WIDTH
  )(
    input  logic[2:0]               op,
    input  logic[OPERAND_WIDTH-1:0] lhs,
    input  logic[OPERAND_WIDTH-1:0] rhs,
    output logic[OPERAND_WIDTH-1:0] res,
  );

  // And Operation
  AndOp and_op;
  AndOpImpl and_op_impl(.iface(and_op));

  // Or Operation
  OrOp or_op;
  OrOpImpl or_op_impl(.iface(or_op));

  // Xor Operation
  XorOp xor_op;
  XorOpImpl xor_op_impl(.iface(xor_op));

  // Create the DUT
  LogicUnit iface;
  LogicUnitImpl dut(.iface(iface), .and_op(and_op), .or_op(or_op), .xor_op(xor_op));

  // Wire the DUT up for testing
  LogicUnitHarness harness(.lhs(lhs), .rhs(rhs), .res(res), .dut(dut));
endmodule;

/** Top-level module for unit testing on a device */
module LogicUnitUnitTestDevice
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
module LogicUnitIntegrationTestDevice
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