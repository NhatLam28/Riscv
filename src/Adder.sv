module Adder #(
    WIDTH = 32
) (
    input   [WIDTH - 1 : 0] a,
    input   [WIDTH - 1 : 0] b,
    output  [WIDTH - 1 : 0] sum,
    output  overflow
);
    wire [WIDTH : 0] tmp;

    assign tmp = a + b;
    assign sum = tmp[WIDTH - 1 : 0];
    assign overflow = tmp[WIDTH];

endmodule
