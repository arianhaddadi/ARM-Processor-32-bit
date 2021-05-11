`include "constants.h"

module ID_Stage
(
	input                     			  clk,
	input                				  rst,
	input 								  Freeze,
	input 								  WB_EN,
	input  [3:0]                          Status_Register,
	input  [`REG_FILE_DEPTH-1:0]	      WB_Dest,
	input  [`WORD_WIDTH-1:0]    		  PC_in,
	input  [`WORD_WIDTH-1:0]    		  instruction_in,
	input  [`WORD_WIDTH-1:0]   			  WB_Value,
	
	output                                MEM_R_EN_out,
	output                                MEM_W_EN_out,
	output                                WB_EN_out,
	output                                Imm_out,
	output                                B_out,
	output                                S_out,
	output                                with_src2,
	output                                with_src1,
	output [3:0]						  EX_CMD_out,
	output [`REG_FILE_DEPTH-1:0] 		  Reg_src1,
	output [`REG_FILE_DEPTH-1:0] 		  Reg_src2,
	output [`REG_FILE_DEPTH-1:0] 		  Reg_Dest,
	output [`SIGNED_IMM_WIDTH-1:0]        signed_immediate,
	output [`SHIFTER_OPERAND_WIDTH-1:0]   shifter_operand,
	output [`WORD_WIDTH-1:0]   			  PC_out,
	output [`WORD_WIDTH-1:0]			  Val_Rn,
	output [`WORD_WIDTH-1:0]			  Val_Rm
);

	wire MEM_R, MEM_W, WB_EN_CU, Imm, SR_update, B, COND_State;
	wire [3:0] EX_CMD;
	wire [8:0] MUX_CU_in, MUX_CU_out, MUX_CU_EN;

	assign {S_out, B_out, EX_CMD_out, MEM_W_EN_out, MEM_R_EN_out, WB_EN_out} = MUX_CU_out;
	assign Imm_out = instruction_in[25];
	assign with_src2 = (~instruction_in[25]) | MEM_W;
	assign signed_immediate = instruction_in[23:0];
	assign shifter_operand = instruction_in[11:0];
	assign PC_out = PC_in;
	assign MUX_CU_EN = (~COND_State) | Freeze;
	assign MUX_CU_in = {SR_update, B, EX_CMD, MEM_W, MEM_R, WB_EN_CU};
	assign Reg_Dest = instruction_in[15:12];
	assign Reg_src1 = instruction_in[19:16];

	MUX_2_to_1 #(.WORD_WIDTH(4)) mux_2_to_1_Reg (
		.select(MEM_W),
		.inp1(instruction_in[3:0]), 
		.inp2(instruction_in[15:12]),
		.out(Reg_src2)
	);

	MUX_2_to_1 #(.WORD_WIDTH(9)) mux_2_to_1_CU (
		.select(MUX_CU_EN),
		.inp1(MUX_CU_in), 
		.inp2(9'b0),
		.out(MUX_CU_out)
	);


	Register_File register_file(
		.clk(clk), 
		.rst(rst),
		.WB_EN(WB_EN),
		.WB_Dest(WB_Dest),
		.src1(Reg_src1), 
		.src2(Reg_src2),
		.WB_Res(WB_Value),
		.reg1(Val_Rn), 
		.reg2(Val_Rm)
	);

	Condition_Check condition_check (
		.condition(instruction_in[31:28]),
		.Status_Register(Status_Register),
		.state(COND_State)
	);

	Control_Unit control_unit (
		.S(instruction_in[20]),
		.mode(instruction_in[27:26]), 
		.OP(instruction_in[24:21]),
		.SR_update(SR_update),
		.with_src1(with_src1)
		.MEM_R(MEM_R), 
		.MEM_W(MEM_W),
		.WB_EN(WB_EN_CU), 
		.B(B),
		.EX_CMD(EX_CMD),
	);


endmodule
