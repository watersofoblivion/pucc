/**
 * Arithmetic Unit
 * ===
 *
 * The arithmetic portion of the ALU
 */
interface ArithUnit;
  /*
   * Parameters
   */
  
  /// The bitwidth of the operands
  parameter OPERAND_WIDTH;

  /*
   * Signals
   */
  
  /// The operation
  logic [1:0] operation;

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
  modport Injected (output operation, lhs, rhs, input result);ß
endinterface;

/*
 * Implementation
 */

module ArithUnitImpl(ArithUnit.Impl iface, AddOp.Injected add_op, SubOp.Injected sub_op);
endmodule;

module ArithUnitAbstraction(ArithUnit.Impl iface, AddOp.Injected add_op, SubOb.Injected sub_op);
endmodule;

/*
 * Testing
 */

/** Testing harness to wire inputs and outputs to an interface */
module ArithUnitHarness
  #(
    OPERAND_WIDTH
  )(
    input  logic[1:0]               op,
    input  logic[OPERAND_WIDTH-1:0] lhs,
    input  logic[OPERAND_WIDTH-1:0] rhs,
    output logic[OPERAND_WIDTH-1:0] res,
    ArithUnit.Injected              dut
  );

  // Wire the inputs and outputs
  assign dut.op  = op;
  assign dut.lhs = lhs;
  assign dut.rhs = rhs;
  assign res = dut.res;
endmodule;

/** Top-level module for unit testing with Verilator */
module ArithUnitUnitTestVerilator
  #(
    OPERAND_WIDTH
  )(
    // Addition Operation
    output logic[OPERAND_WIDTH-1:0] add_op_lhs;
    output logic[OPERAND_WIDTH-1:0] add_op_rhs;
    input  logic[OPERAND_WIDTH-1:0] add_op_res;

    // Subtraction Operation
    output logic[OPERAND_WIDTH-1:0] sub_op_lhs;
    output logic[OPERAND_WIDTH-1:0] sub_op_rhs;
    input  logic[OPERAND_WIDTH-1:0] sub_op_res;

    // Aritmetic hUnit
    input  logic[1:0]               op,
    input  logic[OPERAND_WIDTH-1:0] lhs,
    input  logic[OPERAND_WIDTH-1:0] rhs,
    output logic[OPERAND_WIDTH-1:0] res
  );

  // Addition Operation
  AddOp add_op;
  always_comb begin
    // Assign operands to outputs
    add_op_lhs = add_op.lhs;
    add_op_rhs = add_op.rhs;

    // Read result from inputs
    add_op.res = add_op_res;
  end

  // Subtraction Operation
  SubOp sub_op;
  always_comb begin
    // Assign operands to outputs
    sub_op_lhs = sub_op.lhs;
    sub_op_rhs = sub_op.rhs;

    // Read result from inputs
    sub_op.res = sub_op_res;
  end
  
  // Create the DUT
  ArithUnit iface;
  ArithUnitImpl dut(.iface(iface), .add_op(add_op), .sub_op(sub_op));

  // Wire the DUT up for testing
  ArithUnitHarness harness(.lhs(lhs), .rhs(rhs), .res(res), .dut(dut));
endmodule;

/** Top-level module for integration testing with Verilator */
module ArithUnitIntegrationTestVerilator
  #(
    OPERAND_WIDTH
  )(
    input  logic[1:0]             op,
    input  logic[OPERAND_WIDTH-1:0] lhs,
    input  logic[OPERAND_WIDTH-1:0] rhs,
    output logic[OPERAND_WIDTH-1:0] res,
  );

  // Addition Operation
  AddOp add_op;
  AddOpImpl add_op_impl(.iface(add_op));

  // Subtraction Operation
  SubOp sub_op;
  SubOpImpl sub_op_impl(.iface(sub_op));

  // Create the DUT
  ArithUnit iface;
  ArithUnitImpl dut(.iface(iface), .add_op(add_op), .sub_op(sub_op));

  // Wire the DUT up for testing
  ArithUnitHarness harness(.lhs(lhs), .rhs(rhs), .res(res), .dut(dut));
endmodule;

/** Top-level module for unit testing on a device */
module ArithUnitUnitTestDevice
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
module ArithUnitIntegrationTestDevice
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