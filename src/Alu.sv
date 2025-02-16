module Alu #(
    WIDTH = 32
) (
    input [WIDTH - 1 : 0]   i0,
    input [WIDTH - 1 : 0]   i1,
    input [        3 : 0]   s,
    output[WIDTH - 1 : 0]   o
);

    wire [WIDTH - 1 : 0] sum, sll, srl, sra, slt, sltu, xo_r, o_r, an_d;
    wire [WIDTH     : 0] diff_unsign, diff_sign;
    wire [4         : 0] shamt = i1[4 : 0];
    wire                 sign_0 = i0[WIDTH - 1], sign_1 = i1[WIDTH - 1];   
    wire                 pos_neg, neg_pos, s0;
    wire [WIDTH - 1 : 0] tmp0, tmp1, tmp2;
    
    assign diff_sign    = {sign_0, i0}  - {sign_0, i1};
	assign diff_unsign 	=   {1'b0, i0}  -   {1'b0, i1};

    assign neg_pos  = (sign_0 && ~sign_1) ? 1'b1 : 1'b0;
    assign pos_neg  = (~sign_0 && sign_1) ? 1'b1 : 1'b0;

    assign slt  = neg_pos ? 32'd1 : pos_neg ? 32'd0 : diff_sign ? 32'd1 : 32'd0;
    assign sltu = diff_unsign[WIDTH] ? 32'd1 : 32'd0;

    assign sum  = i0 + i1;

    assign sll 	= i0 << shamt;

    assign xo_r = i0 ^ i1;
	
	assign o_r  = i0 | i1;
	
	assign an_d = i0 & i1;
	
	assign srl  = i0 >> shamt;

    assign sra  = ({WIDTH{sign_0}} << (WIDTH - shamt)) | srl;

    Mux2_1 #(.WIDTH (WIDTH)) re2(.i0(o_r), .i1(an_d), .s(s[0]), .o(tmp1));

    assign s0 = s[3] & ~(|s[2:1]); 
    Mux2_1 #(.WIDTH (WIDTH)) m211(.i0({WIDTH{1'bz}}), .i1(tmp1), .s(s0), .o(tmp2));
    
    Mux2_1 #(.WIDTH (WIDTH)) m1(.i0(tmp0), .i1(tmp2), .s(s[3]), .o(o));

endmodule
