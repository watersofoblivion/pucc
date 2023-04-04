/**
 * Interface of the Thru-Wire component.
 */
interface HDubCoreThruWireIf;
    /**
     * The input signal.
     */
    logic [0:0] in;

    /**
     * The echoed output signal.
     */
    logic [0:0] out;

    /**
     * The ports from the perspective of the implementor.
     */
    modport Impl (input in, output out);

    /**
     * The ports when injected into a component.
     */
    modport Injected (input out, output in);
endinterface;
