`ifndef CORES_ALU_ARITH_ADD_OP_FORMAL_ABSTRACTION
`define CORES_ALU_ARITH_ADD_OP_FORMAL_ABSTRACTION

/** Formal Verification Abstraction */
module AddOpAbstraction(iface);
  /*
   * Signals
   */

  AddOp.Impl iface;

  /*
   * Implementation
   */

  result: assume (iface.result == iface.lhs + iface.rhs);
endmodule;

`endif