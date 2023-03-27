/*
 * A top-level module for Verilator
 */
module GateFactoryTop(
    input logic lhs,
    input logic rhs,
    input logic operand,
    output logic and_result,
    output logic or_result,
    output logic xor_result,
    output logic not_result
);
    // Create an AND gate and inject it into a harness
    HDubCoreLogicBinGateIf and_iface;
    HDubCoreLogicBinGateFactory #(.GATE_TYPE(hdub_core_logic_gate::GATE_AND)) and_gate (.iface(and_iface));
    BinGateHarness and_harness(.lhs(lhs), .rhs(rhs), .result(and_result), .dut(and_iface));

    // Create an OR gate and inject it into a harness
    HDubCoreLogicBinGateIf or_iface;
    HDubCoreLogicBinGateFactory #(.GATE_TYPE(hdub_core_logic_gate::GATE_OR)) or_gate (.iface(or_iface));
    BinGateHarness or_harness(.lhs(lhs), .rhs(rhs), .result(or_result), .dut(or_iface));

    // Create an XOR gate and inject it into a harness
    HDubCoreLogicBinGateIf xor_iface;
    HDubCoreLogicBinGateFactory #(.GATE_TYPE(hdub_core_logic_gate::GATE_XOR)) xor_gate (.iface(xor_iface));
    BinGateHarness xor_harness(.lhs(lhs), .rhs(rhs), .result(xor_result), .dut(xor_iface));

    // Create a NOT gate and inject it into a harness
    HDubCoreLogicUnGateIf not_iface;
    HDubCoreLogicUnGateFactory #(.GATE_TYPE(hdub_core_logic_gate::GATE_NOT)) not_gate (.iface(not_iface));
    UnGateHarness not_harness(.operand(operand), .result(not_result), .dut(not_iface));
endmodule;