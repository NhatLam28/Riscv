module Mux2_1 #(
    WIDTH = 32
) (
    input   [WIDTH - 1 : 0] i0,
    input   [WIDTH - 1 : 0] i1,
    input                   s,
    output  [WIDTH - 1 : 0] o
);

    assign o = s ? i1 : i0;
    
endmodule