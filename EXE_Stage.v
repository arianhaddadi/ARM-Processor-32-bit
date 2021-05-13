module EXE_Stage
(
    input                               clk,
    input                               rst,
    input                               I,
    input                               MEM_R_EN_in,
    input                               MEM_W_EN_in,
    input                               WB_EN_in,
    input                               B_in,
    input  [3:0]                        EXE_CMD,
    input  [3:0]                        Status_Register_in,
    input  [3:0]                        Dest_in,
    input  [11:0]                       shifter_operand,
    input  [23:0]                       signed_immediate,
    input  [31:0]                       PC_in,
    input  [31:0]                       Val_Rn_in,
    input  [31:0]                       Val_Rm_in,

    output                              MEM_R_EN_out,
    output                              MEM_W_EN_out,
    output                              WB_EN_out,
    output                              B_out,
    output [3:0]                        Status_Register_out,
    output [3:0]                        Dest_out,
    output [31:0]                       ALU_Res,
    output [31:0]                       Val_Rm_out,
    output [31:0]                       Branch_Address
);

    wire for_mem;
    wire [31:0] val2;

    assign MEM_R_EN_out = MEM_R_EN_in;
    assign MEM_W_EN_out = MEM_W_EN_in;
    assign WB_EN_out = WB_EN_in;
    assign B_out = B_in;
    assign Dest_out = Dest_in;
    assign Val_Rm_out = Val_Rm_in;
    assign for_mem = MEM_R_EN_in | MEM_W_EN_in;

    Val2_Generate val2_generate(
        .I(I),
        .for_mem(for_mem),
        .shifter_operand(shifter_operand),
        .Val_Rm(Val_Rm_in),
        .Val2_out(val2)
    );

    Adder adder(
        .a(PC_in),
        .b({{(8){signed_immediate[23]}}, signed_immediate}),
        .out(Branch_Address)
    );

    ALU alu(
        .val1(Val_Rn_in),
        .val2(val2),
        .EXE_CMD(EXE_CMD),
        .carry(Status_Register_in[2]),
        .result(ALU_Res),
        .SR(Status_Register_out)
    );


endmodule
