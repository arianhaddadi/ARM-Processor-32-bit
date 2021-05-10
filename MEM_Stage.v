`include "constants.h"

module MEM_Stage
(
    input                        clk, 
    input                        rst,
    input                        MEM_R_EN_in,
    input                        MEM_W_EN_in,
    input                        WB_EN,
    input [`REG_FILE_DEPTH-1:0]  Dest_in,
    input [`WORD_WIDTH-1:0]      Val_Rm,
    input [`WORD_WIDTH-1:0]      ALU_res,

    output                       MEM_R_EN_out,
    output                       WB_EN_out,
    output [`REG_FILE_DEPTH-1:0] Dest_out,
    output [`WORD_WIDTH-1:0]     ALU_res_out,
    output [`WORD_WIDTH-1:0]     MEM_out
);

    assign MEM_R_EN_out = MEM_R_EN_in;
    assign WB_EN_out = WB_EN;
    assign Dest_out = Dest_in;
    assign ALU_res_out = ALU_res;

    Memory M1(
        .clk(clk),
        .rst(rst),
        .MEM_W_EN(MEM_W_EN_in),
        .MEM_R_EN(MEM_R_EN_in),
        .ALU_res(ALU_res),
        .Val_Rm(Val_Rm),
        .MEM_out(MEM_out)
    );

endmodule