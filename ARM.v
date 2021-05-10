`include "constants.h"

module ARM
(
    input clk,
    input rst
);

    wire EXE_stage_B_out;
    wire has_hazard;
    wire [`WORD_WIDTH-1:0] IF_stage_pc_out;
    wire [`WORD_WIDTH-1:0] IF_stage_instruction_out;
    wire [`WORD_WIDTH-1:0] branch_address;

    IF_Stage if_stage (
        .clk(clk),
        .rst(rst),
        .Freeze(has_hazard),
        .Branch_Taken(EXE_stage_B_out),
        .Branch_Address(branch_address),
        .PC_Stage_out(IF_stage_pc_out),
        .instruction(IF_stage_instruction_out)
    );

    wire [`WORD_WIDTH-1:0] IF_reg_pc_out;
    wire [`WORD_WIDTH-1:0] IF_reg_instruction_out;

    IF_Stage_Reg  if_state_reg (
        .clk(clk),
        .rst(rst),
        .Freeze(has_hazard),
        .Flush(EXE_stage_B_out),
        .PC_in(IF_stage_pc_out),
        .instruction_in(IF_stage_instruction_out),
        .instruction_out(IF_reg_instruction_out),
        .PC_out(IF_reg_pc_out)
    );

    wire                              ID_stage_mem_read_out, ID_stage_mem_write_out, ID_stage_WB_en_out, ID_stage_Imm_out, ID_stage_B_out, ID_stage_SR_update_out;
    wire                              WB_Stage_WB_en_out;
    wire                              has_src2;
    wire [3:0]                        ID_stage_EX_command_out;
    wire [3:0]                        status;
    wire [`REG_FILE_DEPTH-1:0] 		  ID_stage_reg_file_dst;
    wire [`REG_FILE_DEPTH-1:0] 		  ID_stage_reg_file_src1, ID_stage_reg_file_src2;
    wire [`SIGNED_IMM_WIDTH-1:0] 	  ID_stage_signed_immediate;
    wire [`SHIFTER_OPERAND_WIDTH-1:0] ID_stage_shifter_operand;
    wire [`WORD_WIDTH-1:0] 			  ID_stage_val_Rn, ID_stage_val_Rm;
    wire [`WORD_WIDTH-1:0]            ID_stage_pc_out;
    wire [`REG_FILE_DEPTH-1:0]        WB_Stage_dst_out;
    wire [`WORD_WIDTH-1:0]            WB_Value;

    ID_Stage id_stage(
        .clk(clk),
        .rst(rst),
        .Freeze(has_hazard),
        .PC_in(IF_reg_pc_out),
        .instruction_in(IF_reg_instruction_out),
        .reg_file_wb_address(WB_Stage_dst_out),
        .reg_file_wb_data(WB_Value),
        .reg_file_enable(WB_Stage_WB_en_out),
        .reg_file_src1(ID_stage_reg_file_src1),
        .reg_file_src2(ID_stage_reg_file_src2),
        .Status_Register(status),
        .PC_out(ID_stage_pc_out),
        .reg_file_dst(ID_stage_reg_file_dst),
        .val_Rn(ID_stage_val_Rn), .val_Rm(ID_stage_val_Rm),
        .signed_immediate(ID_stage_signed_immediate),
        .shifter_operand(ID_stage_shifter_operand),
        .EX_command_out(ID_stage_EX_command_out),
        .mem_read_out(ID_stage_mem_read_out), .mem_write_out(ID_stage_mem_write_out),
        .WB_EN_out(ID_stage_WB_en_out),
        .Imm_out(ID_stage_Imm_out),
        .B_out(ID_stage_B_out),
        .S_out(ID_stage_SR_update_out),
        .has_src2(has_src2),
        .has_src1(has_src1)
    );

    wire ID_reg_mem_read_out, ID_reg_mem_write_out, ID_reg_WB_en_out, ID_reg_Imm_out, ID_reg_B_out, ID_reg_SR_update_out;
    wire [3:0] ID_reg_SR_out, ID_reg_EX_command_out;
    wire [`WORD_WIDTH-1:0] ID_reg_pc_out;
    wire [`REG_FILE_DEPTH-1:0] ID_reg_reg_file_dst_out;
    wire [`WORD_WIDTH-1:0] ID_reg_val_Rn_out, ID_reg_val_Rm_out;
    wire [`SIGNED_IMM_WIDTH-1:0] ID_reg_signed_immediate_out;
    wire [`SHIFTER_OPERAND_WIDTH-1:0] ID_reg_shifter_operand_out;

    ID_Stage_Reg id_stage_reg(
        .clk(clk),
        .rst(rst),
        .Flush(EXE_stage_B_out),
        .MEM_R_EN_in(ID_stage_mem_read_out), 
        .MEM_W_EN_in(ID_stage_mem_write_out),
        .WB_EN_in(ID_stage_WB_en_out),
        .Imm_in(ID_stage_Imm_out),
        .B_in(ID_stage_B_out),
        .S_in(ID_stage_SR_update_out),
        .EX_CMD_in(ID_stage_EX_command_out),
        .status_register_in(status),
        .Dest_in(ID_stage_reg_file_dst),
        .signed_immediate_in(ID_stage_signed_immediate),
        .shifter_operand_in(ID_stage_shifter_operand),
        .PC_in(ID_stage_pc_out),
        .Val_Rn_in(ID_stage_val_Rn), 
        .Val_Rm_in(ID_stage_val_Rm),
        .MEM_R_EN_out(ID_reg_mem_read_out), 
        .MEM_W_EN_out(ID_reg_mem_write_out),
        .WB_EN_out(ID_reg_WB_en_out),
        .Imm_out(ID_reg_Imm_out),
        .B_out(ID_reg_B_out),
        .S_out(ID_reg_SR_update_out),
        .EX_CMD_out(ID_reg_EX_command_out),
        .status_register_out(ID_reg_SR_out),
        .signed_immediate_out(ID_reg_signed_immediate_out),
        .shifter_operand_out(ID_reg_shifter_operand_out),
        .Dest_out(ID_reg_reg_file_dst_out),
        .PC_out(ID_reg_pc_out),
        .Val_Rn_out(ID_reg_val_Rn_out), 
        .Val_Rm_out(ID_reg_val_Rm_out)
    );

    wire [`REG_FILE_DEPTH-1:0] EXE_stage_reg_file_dst_out;
    wire [`WORD_WIDTH-1:0] EXE_stage_val_Rm_out;
    wire [3:0] EXE_stage_SR_out;
    wire [`WORD_WIDTH-1:0] ALU_res;
    wire EXE_stage_mem_read_out, EXE_stage_mem_write_out, EXE_stage_WB_en_out;

    EXE_Stage exe_stage(
        .clk(clk),
        .rst(rst),
        .imm(ID_reg_Imm_out),
        .MEM_R_EN_in(ID_reg_mem_read_out), 
        .MEM_W_EN_in(ID_reg_mem_write_out),
        .WB_EN_in(ID_reg_WB_en_out),
        .B_in(ID_reg_B_out),
        .EXE_CMD(ID_reg_EX_command_out),
        .Status_Register_in(ID_reg_SR_out),
        .signed_immediate(ID_reg_signed_immediate_out),
        .shifter_operand(ID_reg_shifter_operand_out),
        .Dest_in(ID_reg_reg_file_dst_out),
        .PC_in(ID_reg_pc_out),
        .Val_Rn_in(ID_reg_val_Rn_out), 
        .Val_Rm_in(ID_reg_val_Rm_out),
        .MEM_R_EN_out(EXE_stage_mem_read_out), 
        .MEM_W_EN_out(EXE_stage_mem_write_out),
        .WB_EN_out(EXE_stage_WB_en_out),
        .B_out(EXE_stage_B_out),
        .Status_Register_out(EXE_stage_SR_out),
        .Dest_out(EXE_stage_reg_file_dst_out),
        .ALU_Res(ALU_res),
        .Val_Rm_out(EXE_stage_val_Rm_out),
        .Branch_Address(branch_address)
    );

    wire [`REG_FILE_DEPTH-1:0] EXE_reg_dst_out;
    wire [`WORD_WIDTH-1:0] EXE_reg_ALU_res_out;
    wire [`WORD_WIDTH-1:0] EXE_reg_val_Rm_out;
    wire EXE_reg_mem_read_out, EXE_reg_mem_write_out, EXE_reg_WB_en_out;

    EXE_Stage_Reg exe_stage_reg(
        .clk(clk),
        .rst(rst),
        .MEM_R_EN_in(EXE_stage_mem_read_out), 
        .MEM_W_EN_in(EXE_stage_mem_write_out),
        .WB_EN_in(EXE_stage_WB_en_out),
        .Dest_in(EXE_stage_reg_file_dst_out),
        .Val_Rm_in(EXE_stage_val_Rm_out),
        .ALU_Res_in(ALU_res),
        .MEM_R_EN_out(EXE_reg_mem_read_out), 
        .MEM_W_EN_out(EXE_reg_mem_write_out),
        .WB_EN_out(EXE_reg_WB_en_out),
        .Dest_out(EXE_reg_dst_out),
        .ALU_Res_out(EXE_reg_ALU_res_out),
        .Val_Rm_out(EXE_reg_val_Rm_out)
    );

    wire [`REG_FILE_DEPTH-1:0] Mem_Stage_dst_out;
    wire [`WORD_WIDTH-1:0] Mem_Stage_ALU_res_out;
    wire [`WORD_WIDTH-1:0] Mem_Stage_mem_out;
    wire Mem_Stage_read_out, Mem_Stage_WB_en_out;

    Mem_Stage mem_stage(
        .clk(clk),
        .rst(rst),
        .MEM_R_EN_in(EXE_reg_mem_read_out),
        .MEM_W_EN_in(EXE_reg_mem_write_out),
        .WB_EN(EXE_reg_WB_en_out),
        .Dest_in(EXE_reg_dst_out),
        .Val_Rm(EXE_reg_val_Rm_out),
        .ALU_res(EXE_reg_ALU_res_out),
        .MEM_R_EN_out(Mem_Stage_read_out),
        .WB_EN_out(Mem_Stage_WB_en_out),
        .Dest_out(Mem_Stage_dst_out),
        .ALU_res_out(Mem_Stage_ALU_res_out),
        .MEM_out(Mem_Stage_mem_out)
    );

    wire [`REG_FILE_DEPTH-1:0] Mem_Reg_dst_out;
    wire [`WORD_WIDTH-1:0] Mem_Reg_ALU_res_out;
    wire [`WORD_WIDTH-1:0] Mem_Reg_mem_out;
    wire Mem_Reg_read_out, Mem_Reg_WB_en_out;

    MEM_Stage_Reg mem_stage_reg(
        .clk(clk),
        .rst(rst),
        .MEM_R_EN_in(Mem_Stage_read_out),
        .WB_EN_in(Mem_Stage_WB_en_out),
        .Dest_in(Mem_Stage_dst_out),
        .ALU_Res_in(Mem_Stage_ALU_res_out),
        .MEM_in(Mem_Stage_mem_out),
        .MEM_R_EN_out(Mem_Reg_read_out),
        .WB_EN_out(Mem_Reg_WB_en_out),
        .Dest_out(Mem_Reg_dst_out),
        .ALU_Res_out(Mem_Reg_ALU_res_out),
        .MEM_out(Mem_Reg_mem_out)
    );

    WB_Stage wb_stage(
        .clk(clk),
        .rst(rst),
        .MEM_R_EN(Mem_Reg_read_out),
        .WB_EN(Mem_Reg_WB_en_out),
        .Dest(Mem_Reg_dst_out),
        .ALU_res(Mem_Reg_ALU_res_out),
        .mem(Mem_Reg_mem_out),
        .WB_EN_out(WB_Stage_WB_en_out),
        .WB_Dest(WB_Stage_dst_out),
        .WB_Value(WB_Value)
    );

    Status_Register status_register(
        .clk(clk),
        .rst(rst),
        .S(ID_reg_SR_update_out),
        .status_in(EXE_stage_SR_out),
        .status_out(status)
    );

    wire EXE_WB_en = ID_reg_WB_en_out;
    wire MEM_WB_en = EXE_reg_WB_en_out;
    wire[`REG_FILE_DEPTH-1:0] EXE_dest = ID_reg_reg_file_dst_out;
    wire[`REG_FILE_DEPTH-1:0] MEM_dest = EXE_reg_dst_out;

    Hazard_Detection_Unit hazard_detection_unit(
        .EXE_WB_EN(EXE_WB_en),
        .MEM_WB_EN(MEM_WB_en),
        .with_src1(has_src1),
        .with_src2(has_src2),
        .src1(ID_stage_reg_file_src1),
        .src2(ID_stage_reg_file_src2),
        .EXE_Dest(EXE_dest),
        .MEM_Dest(MEM_dest),
        .has_hazard(has_hazard)
    );

endmodule

