/**
 * ALU
 * ===
 *
 * An arithmetic and logic unit.
 */
interface Alu;
  /*
   * Parameters
   */
  
  /// The bitwidth of the operands
  parameter OPERAND_WIDTH;

  /*
   * Signals
   */
  
  /// The operation to perform
  logic [4:0] operation;

  /// The operands
  logic [OPERAND_WIDTH:0] lhs;
  logic [OPERAND_WIDTH:0] rhs;

  /// The result
  logic [OPERAND_WIDTH:0] result;

  /*
   * Modports
   */
  
  /// The ports from the perspective of the implementation
  modport Impl (input operation, lhs, rhs, output result);

  /// The ports when injected into a component
  modport Injected (output operation, lhs, rhs, input result);
endinterface;

module AluImpl(Alu.Impl iface, ArithUnit.Injected arith_unit, LogicUnit.Injected logic_unit);
endmodule;