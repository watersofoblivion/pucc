/**
 * A harness to inject the DUT into.
 */
module IntegrationTestHarness(
    input logic [0:0] in,
    output logic [0:0] out,
    HDubCoreThruWireIf.Injected dut
);

    // Just copy the inputs and outputs
    assign dut.in = in;
    assign out = dut.out;
endmodule;
