/** Top-level module for integration testing with Verilator */
module AddOpImplNativeTestIntegVerilator (lhs, rhs, result);
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
  
   // Create the DUT
  AddOp #(.OPERAND_WIDTH(OPERAND_WIDTH)) iface;
  AddOpImplNative #(.OPERAND_WIDTH(OPERAND_WIDTH)) dut(.iface(iface));

  // Wire the DUT up for testing
  AddOpTestHarness #(.OPERAND_WIDTH(OPERAND_WIDTH)) harness(.lhs(lhs), .rhs(rhs), .result(result), .dut(iface));
endmodule;
