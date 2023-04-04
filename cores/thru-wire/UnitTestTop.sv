/*
 * A top-level module for Verilator
 */
module UnitTestTop(
    input logic [0:0] in,
    output logic [0:0] out
);
    // Create the DUT
    HDubCoreThruWireIf iface;
    HDubCoreThruWire dut(.iface(iface));

    // Inject the DUT into the harness
    UnitTestHarness harness(.in(in), .out(out), .dut(iface));
endmodule;