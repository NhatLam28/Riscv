module Mux4_1 #(
    WIDTH = 32
) (
    input   [WIDTH - 1 : 0] i0  ,
    input   [WIDTH - 1 : 0] i1  ,
    input   [WIDTH - 1 : 0] i2  ,
    input   [WIDTH - 1 : 0] i3  ,
    input   [1         : 0] s   ,
    output  [WIDTH - 1 : 0] o   
);

    wire    [WIDTH - 1 : 0] tmp0, tmp1;

    Mux2_1 #(.WIDTH(WIDTH)) m0 (.i0(i0), .i1(i1), .s(s[0]), .o(tmp0));
    Mux2_1 #(.WIDTH(WIDTH)) m1 (.i0(i2), .i1(i3), .s(s[0]), .o(tmp1));

    Mux2_1 #(.WIDTH(WIDTH)) m2 (.i0(tmp0), .i1(tmp1), .s(s[1]), .o(o));

endmodule
