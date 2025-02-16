module Imm_encoding #(
    WIDTH = 32
) (
    input [WIDTH - 1 : 0] instr,
    input [2         : 0] s,
    output[WIDTH - 1 : 0] imm
);

    wire [WIDTH - 1 : 0] I_type, S_type, B_type, U_type, J_type;
    wire [WIDTH - 1 : 0] S0, S1;

    assign I_type = {{20{instr[31]}}, instr[31:20]};
    assign S_type = {{20{instr[31]}}, instr[31:25], instr[11:7]};
    assign B_type = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};
    assign U_type = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};
    assign J_type = {instr[31:12], 12'd0};

    Mux4_1 #(.WIDTH (WIDTH)) mx41 (
        .i0 (I_type),
        .i1 (S_type),
        .i2 (B_type),
        .i3 (U_type),
        .s  (s[1:0]),
        .o  (S0)
    );

    assign S1 = |s[1:0] ? 32'bz : J_type;

    Mux2_1 #(.WIDTH (WIDTH)) mx21 (
        .i0 (S0),
        .i1 (S1),
        .s  (s[2]),
        .o  (imm)
    );

endmodule