interface HDubCoreLogicBitwiseUnOpIf#(WIDTH = 1);
    logic [WIDTH-1:0] operand;
    logic [WIDTH-1:0] result;

    modports Impl (input operand, output result);
    modports Inject (input result, output operand);
endinterface