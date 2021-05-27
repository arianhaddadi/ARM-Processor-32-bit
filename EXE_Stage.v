module EXE_Stage
(
    input                               clk,
    input                               rst,
    input                               I,
    input                               MEM_R_EN_in,
    input                               MEM_W_EN_in,
    input                               WB_EN_in,
    input                               B_in,
    input  [1:0]                        Forwarding_Sel1,
    input  [1:0]                        Forwarding_Sel2,     
    input  [3:0]                        EXE_CMD,
    input  [3:0]                        Status_Register_in,
    input  [3:0]                        Dest_in,
    input  [11:0]                       shifter_operand,
    input  [23:0]                       signed_immediate,
    input  [31:0]                       PC_in,
    input  [31:0]                       Val_Rn_in,
    input  [31:0]                       Val_Rm_in,
    input  [31:0]                       MEM_ALU_RES,
    input  [31:0]                       WB_ALU_RES,

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
    wire [31:0] val2, mux_4_to_1_src1_out, mux_4_to_1_src2_out;

    assign MEM_R_EN_out = MEM_R_EN_in;
    assign MEM_W_EN_out = MEM_W_EN_in;
    assign WB_EN_out = WB_EN_in;
    assign B_out = B_in;
    assign Dest_out = Dest_in;
    assign Val_Rm_out = Val_Rm_in;
    assign for_mem = MEM_R_EN_in | MEM_W_EN_in;
    
    MUX_4_to_1 #(.WORD_WIDTH(32)) mux_4_to_1_src1 (
		  .select(Forwarding_Sel1),
		  .inp1(Val_Rn_in), 
		  .inp2(MEM_ALU_RES),
		  .inp3(WB_ALU_RES),
		  .inp4(32'b0),
		  .out(mux_4_to_1_src1_out)
	  );
	
    MUX_4_to_1 #(.WORD_WIDTH(32)) mux_4_to_1_src2 (
		  .select(Forwarding_Sel2),
		  .inp1(Val_Rm_in), 
		  .inp2(MEM_ALU_RES),
		  .inp3(WB_ALU_RES),
		  .inp4(32'b0),
		  .out(mux_4_to_1_src2_out)
	  );

    Val2_Generate val2_generate(
        .I(I),
        .for_mem(for_mem),
        .shifter_operand(shifter_operand),
        .Val_Rm(mux_4_to_1_src2_out),
        .Val2_out(val2)
    );

    Adder adder(
        .a(PC_in),
        .b({{(8){signed_immediate[23]}}, signed_immediate}),
        .out(Branch_Address)
    );

    ALU alu(
        .val1(mux_4_to_1_src1_out),
        .val2(val2),
        .EXE_CMD(EXE_CMD),
        .carry(Status_Register_in[2]),
        .result(ALU_Res),
        .SR(Status_Register_out)
    );


endmodule
