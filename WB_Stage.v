module WB_Stage
(
    input                        clk,
    input                        rst,
    input                        MEM_R_EN,
    input                        WB_EN,
    input [3:0]                  Dest,
    input [31:0]                 ALU_res,
    input [31:0]                 mem,

    output                       WB_EN_out,
    output [3:0]                 WB_Dest,
    output [31:0]                WB_Value
);

    assign WB_EN_out = WB_EN;
    assign WB_Dest = Dest;

    MUX_2_to_1 #(.WORD_WIDTH(32)) mux_2_to_1_regfile (
        .select(MEM_R_EN),
        .inp1(ALU_res), 
        .inp2(mem),
        .out(WB_Value)
    );

endmodule



