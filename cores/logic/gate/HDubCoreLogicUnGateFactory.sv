module HDubCoreLogicUnGateFactory #(GATE_TYPE) (HDubCoreLogicUnGateIf.Impl iface);
    generate
        case (GATE_TYPE) 
            hdub_core_logic_gate::GATE_NOT: HDubCoreLogicGateNot gate(.iface(iface));
            default: $fatal("Unsupported unary logic gate type: %s", GATE_TYPE.name());
        endcase
    endgenerate
endmodule
