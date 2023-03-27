/*
 * A top-level module for Verilator
 */
module GateNotTop(
    input logic operand,
    output logic result
);
    // Create the DUT
    HDubCoreLogicUnGateIf iface;
    HDubCoreLogicGateNot dut(.iface(iface));

    // Inject the DUT into the harness
    UnGateHarness harness(.operand(operand), .result(result), .dut(iface));
endmodule;