/** Testing harness to wire inputs and outputs to an interface */
module AddOpTestHarness (lhs, rhs, result, dut);
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
  AddOp.Injected                  dut;

  /*
   * Implementation
   */ 

  // Wire the inputs and outputs
  assign dut.lhs = lhs;
  assign dut.rhs = rhs;
  assign result = dut.result;
endmodule;
