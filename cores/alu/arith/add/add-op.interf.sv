`ifndef CORES_ALU_ARITH_ADD_OP_INTERFACE
`define CORES_ALU_ARITH_ADD_OP_INTERFACE

interface AddOp;
  /*
   * Parameters
   */

  /// The bitwidth of the operands
  parameter OPERAND_WIDTH = 32;

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

`endif
