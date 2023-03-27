interface HDubCoreLogicBinGateIf;
    logic lhs;
    logic rhs;
    logic result;

    modport Impl (input lhs, rhs, output result);
    modport Injected (input result, output lhs, rhs);
endinterface