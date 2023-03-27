/*
 * A top-level module for Verilator
 */
module GateOrTop(
    input logic lhs,
    input logic rhs,
    output logic result
);
    // Create the DUT
    HDubCoreLogicBinGateIf iface;
    HDubCoreLogicGateOr dut(.iface(iface));

    // Inject the DUT into the harness
    BinGateHarness harness(.lhs(lhs), .rhs(rhs), .result(result), .dut(iface));
endmodule;