/** Top-level module for unit testing on a device */
module AddOpImplNativeTestUnitDevice (lhs, rhs, result);
  /*
   * Parameters
   */
  
  parameter OPERAND_WIDTH = 32;

  /*
   * Signals
   */
 
  input  logic[OPERAND_WIDTH-1:0] lhs;
  input  logic[OPERAND_WIDTH-1:0] rhs;
  output logic[OPERAND_WIDTH-1:0] result;
 
  /*
   * Implementation
   */
  
  // TODO
endmodule;
