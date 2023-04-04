module HDubCoreLogicBinGateFactory #(GATE_TYPE) (HDubCoreLogicBinGateIf.Impl iface);
    generate
        case (GATE_TYPE) 
            hdub_core_logic_gate::GATE_AND: HDubCoreLogicGateAnd gate(.iface(iface));
            hdub_core_logic_gate::GATE_OR:  HDubCoreLogicGateOr  gate(.iface(iface));
            hdub_core_logic_gate::GATE_XOR: HDubCoreLogicGateXor gate(.iface(iface));
            default: $fatal("Unsupported binary logic gate type: %s", GATE_TYPE.name());
        endcase
    endgenerate
endmodule