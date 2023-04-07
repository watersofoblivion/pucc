module AddOpImplNative (iface);
  /*
   * Parameters
   */
  
  parameter OPERAND_WIDTH = 32;

  /*
   * Signals
   */
  
  AddOp.Impl iface;

  /*
   * Implementation
   */

  assign iface.result = iface.lhs + iface.rhs;
endmodule;
