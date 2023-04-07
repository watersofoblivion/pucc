/** Top-level module for integration testing on a device */
module AddOpImplNativeTestIntegDevice (lhs, rhs, result);
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
