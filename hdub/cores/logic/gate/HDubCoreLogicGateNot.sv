module HDubCoreLogicGateNot(HDubCoreLogicUnGateIf.Impl iface);
    assign iface.result = ~iface.operand;
endmodule
