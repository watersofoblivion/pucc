interface HDubCoreLogicAggIf#(WIDTH = 1);
    logic [WIDTH-1:0] operand;
    logic result;

    modports Impl (input operand, output result);
    modports Inject (input result, output operand);
endinterface