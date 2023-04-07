/**
 * Thru Wire
 * ===
 *
 * Combinatorally echos the input signal to the output signal.
 */

/**
 * Interface
 */
interface ThruWire;
    /*
     * Signals
     */

    /// The input signal
    logic [0:0] in;

    /// The echoed output signal
    logic [0:0] out;

    /*
     * Modports
     */

    /// The ports from the perspective of the implementation
    modport Impl (input in, output out);

    /// The ports when injected into a component
    modport Injected (input out, output in);
endinterface;

/**
 * Factory
 */
module ThruWireFactory(ThruWire.Impl iface);

endmodule;

/**
 * Implementation
 */
module ThruWireImpl(ThruWire.Impl iface);
    // Copy the input value to the output
    assign iface.out = iface.in;
endmodule;

/**
 * Formal Abstraction
 */
module ThruWireAbstraction(ThruWire.Impl iface);
    // Assumptions
    echo: assume (iface.out == iface.in);

    // Coverage targets
    zero: cover (!iface.out);
    one:  cover (iface.out);
endmodule;

/**
 * Test Harness
 */
module ThruWireHarness(
    input logic [0:0] in,
    output logic [0:0] out,
    HDubCoreThruWireIf.Injected dut
);

    // Just copy the inputs and outputs
    assign dut.in = in;
    assign out = dut.out;
endmodule;

/**
 * Top-Level Unit Test module
 */
module ThruWireUnitTest(input logic[0:0] in, output logic[0:0] out);
    // Create the DUT
    ThruWire thru_wire;
    ThruWireImpl dut(.iface(thru_wire));

    // Inject the DUT into the harness
    ThruWireHarness harness(.in(in), .out(out), .dut(dut));
endmodule;

/**
 * Top-Level Integration Test module
 */
module ThruWireIntegrationTest(input logic[0:0] in, output logic[0:0] out);
    // Create the DUT
    ThruWire thru_wire;
    ThruWireImpl dut(.iface(thru_wire));

    // Inject the DUT into the harness
    ThruWireHarness harness(.in(in), .out(out), .dut(dut));
endmodule;