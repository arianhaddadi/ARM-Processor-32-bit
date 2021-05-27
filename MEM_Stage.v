module MEM_Stage
(
    input                        clk, 
    input                        rst,
    input                        MEM_R_EN_in,
    input                        MEM_W_EN_in,
    input                        WB_EN,
    input [3:0]                  Dest_in,
    input [31:0]                 Val_Rm,
    input [31:0]                 ALU_res,

    output                       ready,
    output                       MEM_R_EN_out,
    output                       WB_EN_out,
    output                       SRAM_WE_N,
    output [3:0]                 Dest_out, 
    output [16:0]                SRAM_ADDR,
    output [31:0]                ALU_res_out,
    output [31:0]                MEM_out,

    inout [31:0]                 SRAM_DQ
);

    assign MEM_R_EN_out = MEM_R_EN_in;
    assign WB_EN_out = WB_EN;
    assign Dest_out = Dest_in;
    assign ALU_res_out = ALU_res;

    // Memory M1(
    //     .clk(clk),
    //     .rst(rst),
    //     .MEM_W_EN(MEM_W_EN_in),
    //     .MEM_R_EN(MEM_R_EN_in),
    //     .ALU_res(ALU_res),
    //     .Val_Rm(Val_Rm),
    //     .MEM_out(MEM_out)
    // );

    wire [3:0] SRAM_Control_Signals;

    SRAM_Controller sram_controller (
        .clk(clk),
        .rst(rst),
        .MEM_W_EN(MEM_W_EN_in),
        .MEM_R_EN(MEM_R_EN_in),
        .address(ALU_res),
        .writeData(Val_Rm),
        .ready(ready),
        .SRAM_UB_N(SRAM_Control_Signals[0]),
        .SRAM_LB_N(SRAM_Control_Signals[1]),
        .SRAM_WE_N(SRAM_WE_N),
        .SRAM_CE_N(SRAM_Control_Signals[2]),
        .SRAM_OE_N(SRAM_Control_Signals[3]),
        .SRAM_ADDR(SRAM_ADDR), 
        .readData(MEM_out),
        .SRAM_DQ(SRAM_DQ)
    );

endmodule