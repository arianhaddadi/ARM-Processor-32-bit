`include "constants.h"

module WB_Stage
(
    input                        clk,
    input                        rst,
    input                        MEM_R_EN,
    input                        WB_EN,
    input [`REG_FILE_DEPTH-1:0]  Dest,
    input [`WORD_WIDTH-1:0]      ALU_res,
    input [`WORD_WIDTH-1:0]      mem,

    output                       WB_EN_out,
    output [`REG_FILE_DEPTH-1:0] WB_Dest,
    output [`WORD_WIDTH-1:0]     WB_Value
);

    assign WB_EN_out = WB_EN;
    assign WB_Dest = Dest;

    MUX_2_to_1 #(.WORD_WIDTH(`WORD_WIDTH)) mux_2_to_1_regfile (
        .select(MEM_R_EN),
        .inp1(ALU_res), 
        .inp2(mem),
        .out(WB_Value)
    );

endmodule



