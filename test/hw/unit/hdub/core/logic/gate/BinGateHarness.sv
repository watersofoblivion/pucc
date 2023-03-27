/**
 * A harness to inject the DUT into.
 */
 module BinGateHarness(
    input logic lhs,
    input logic rhs,
    output logic result,
    HDubCoreLogicBinGateIf.Injected dut
);

    // Just copy the inputs and outputs
    assign dut.lhs = lhs;
    assign dut.rhs = rhs;
    assign result = dut.result;
endmodule
