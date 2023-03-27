module HDubCoreLogicGateXor(HDubCoreLogicBinGateIf.Impl iface);
    assign iface.result = iface.lhs ^ iface.rhs;
endmodule
