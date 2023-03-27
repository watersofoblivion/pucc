interface HDubCoreLogicUnGateIf;
    logic operand;
    logic result;

    modport Impl (input operand, output result);
    modport Injected (input result, output operand);
endinterface