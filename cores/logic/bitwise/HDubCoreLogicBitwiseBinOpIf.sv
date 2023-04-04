interface HDubCoreLogicBitwiseBinOpIf#(WIDTH = 1);
    logic [WIDTH-1:0] lhs;
    logic [WIDTH-1:0] rhs;
    logic [WIDTH-1:0] result;

    modports Impl (input lhs, rhs, output result);
    modports Inject (input result, output lhs, rhs);
endinterface