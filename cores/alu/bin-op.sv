/**
 * Binary Operation
 * ===
 *
 * An N-bit binary operation
 */
interface BinOp;
  /*
   * Parameters
   */

  /// The bitwidth of the operands
  parameter OPERAND_WIDTH;

  /*
   * Signals
   */

  /// The operands
  logic [OPERAND_WIDTH:0] lhs;
  logic [OPERAND_WIDTH:0] rhs;

  /// The result
  logic [OPERAND_WIDTH:0] result;

  /*
   * Modports
   */
  
  /// The ports from the perspective of the implementation
  modport Impl (input lhs, rhs, output result);

  /// The ports when injected into a component
  modport Injected (output lhs, rhs, input result);
endinterface;