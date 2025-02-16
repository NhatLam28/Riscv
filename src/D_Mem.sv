module D_Mem #(
    WIDTH = 32
) (
    input   [WIDTH - 1 : 0] Addr,
    input   [WIDTH - 1 : 0] WD,
    input                   MemW, MemR, clk, res,
    input   [2         : 0] instr14to12,
    output  [WIDTH - 1 : 0] RD
);
    reg  [WIDTH/4 - 1 : 0] ram [0:400000];
    wire [WIDTH - 1 : 0] wd0, wd1, rd0, rd1, lb, lh, lbu, lhu;
    wire addr = Addr >> 2;
    integer i = 0;

    Mux4_1 #(.WIDTH (WIDTH)) mx41_store0 (.i0 (WD[7:0]), .i1 (WD[15:0]), .i2 (WD), .i3 ({WIDTH{1'b0}}), .s (instr14to12[1:0]), .o (wd0));
    assign wd1 = instr14to12[2] ? {WIDTH{1'b0}} : wd0;

    always @(posedge clk, negedge res) begin
        if(!res) begin
            for(i = 0; i < 100000; i = i + 1)
            begin
                ram[i] <= {WIDTH{1'b0}};
            end
        end
        else begin
            if(MemW) begin
                ram[addr] = wd1;
            end
        end
    end
    
    assign lb   = {{24{ram[addr][7]}}   , ram[addr][7:0]};
    assign lh   = {{16{ram[addr][15]}}  , ram[addr][15:0]};
    assign lbu  = {{24{1'b0}}           , ram[addr][7:0]};
    assign lhu  = {{16{1'b0}}           , ram[addr][15:0]};

    Mux4_1 #(.WIDTH (WIDTH)) mx41_load0 (.i0 (lb), .i1 (lh), .i2 (ram[Addr]), .i3 ({WIDTH{1'b0}}), .s (s[1:0]), .o (rd0));

    Mux2_1 #(.WIDTH (WIDTH)) mx21_load0 (.i0 (lbu), .i1(lhu), .s(), .o(rd1));

    assign 
endmodule