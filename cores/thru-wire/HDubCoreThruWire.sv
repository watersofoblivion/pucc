/**
 * Echo the input signal to the output signal.
 */
module HDubCoreThruWire(HDubCoreThruWireIf.Impl iface);
    assign iface.out = iface.in;
endmodule;
