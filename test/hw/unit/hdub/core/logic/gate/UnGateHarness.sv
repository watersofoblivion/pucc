/**
 * A harness to inject the DUT into.
 */
 module UnGateHarness(
    input logic operand,
    output logic result,
    HDubCoreLogicUnGateIf.Injected dut
);

    // Just copy the inputs and outputs
    assign dut.operand = operand;
    assign result = dut.result;
endmodule
