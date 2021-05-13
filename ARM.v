module ARM
(
    input clk,
    input rst
);

    wire        EXE_stage_B_out, has_hazard;
    wire [31:0] IF_stage_pc_out, IF_stage_instruction_out, branch_address;

    IF_Stage if_stage (
        .clk(clk),
        .rst(rst),
        .Freeze(has_hazard),
        .Branch_Taken(EXE_stage_B_out),
        .Branch_Address(branch_address),
        .PC_Stage_out(IF_stage_pc_out),
        .instruction(IF_stage_instruction_out)
    );

    wire [31:0] IF_reg_pc_out, IF_reg_instruction_out;

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

    wire        ID_stage_mem_read_out, ID_stage_mem_write_out, ID_stage_WB_en_out, ID_stage_Imm_out, ID_stage_B_out, ID_stage_SR_update_out, WB_Stage_WB_en_out, has_src2;
    wire [3:0]  ID_stage_EX_command_out, status, ID_stage_reg_file_dst, ID_stage_reg_file_src1, ID_stage_reg_file_src2, WB_Stage_dst_out;
    wire [11:0] ID_stage_shifter_operand;
    wire [23:0] ID_stage_signed_immediate;
    wire [31:0] ID_stage_val_Rn, ID_stage_val_Rm, ID_stage_pc_out, WB_Value;

    ID_Stage id_stage(
        .clk(clk),
        .rst(rst),
        .hazard(has_hazard),
        .WB_EN(WB_Stage_WB_en_out),
        .Status_Register(status),
        .WB_Dest(WB_Stage_dst_out),
        .PC_in(IF_reg_pc_out),
        .instruction_in(IF_reg_instruction_out),
        .WB_Value(WB_Value),
        .MEM_R_EN_out(ID_stage_mem_read_out), 
        .MEM_W_EN_out(ID_stage_mem_write_out),
        .WB_EN_out(ID_stage_WB_en_out),
        .Imm_out(ID_stage_Imm_out),
        .B_out(ID_stage_B_out),
        .S_out(ID_stage_SR_update_out),
        .with_src2(has_src2),
        .with_src1(has_src1),
        .EX_CMD_out(ID_stage_EX_command_out),
        .Reg_src1(ID_stage_reg_file_src1),
        .Reg_src2(ID_stage_reg_file_src2),
        .Reg_Dest(ID_stage_reg_file_dst),
        .shifter_operand(ID_stage_shifter_operand),
        .signed_immediate(ID_stage_signed_immediate),
        .PC_out(ID_stage_pc_out),
        .Val_Rn(ID_stage_val_Rn), 
        .Val_Rm(ID_stage_val_Rm)
    );

    wire        ID_reg_mem_read_out, ID_reg_mem_write_out, ID_reg_WB_en_out, ID_reg_Imm_out, ID_reg_B_out, ID_reg_SR_update_out;
    wire [3:0]  ID_reg_SR_out, ID_reg_EX_command_out, ID_reg_reg_file_dst_out;
    wire [11:0] ID_reg_shifter_operand_out;
    wire [23:0] ID_reg_signed_immediate_out;
    wire [31:0] ID_reg_val_Rn_out, ID_reg_val_Rm_out, ID_reg_pc_out;

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
        .Status_Register_in(status),
        .Dest_in(ID_stage_reg_file_dst),
        .shifter_operand_in(ID_stage_shifter_operand),
        .signed_immediate_in(ID_stage_signed_immediate),
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
        .Dest_out(ID_reg_reg_file_dst_out),
        .shifter_operand_out(ID_reg_shifter_operand_out),
        .signed_immediate_out(ID_reg_signed_immediate_out),
        .PC_out(ID_reg_pc_out),
        .Val_Rn_out(ID_reg_val_Rn_out), 
        .Val_Rm_out(ID_reg_val_Rm_out)
    );

    wire        EXE_stage_mem_read_out, EXE_stage_mem_write_out, EXE_stage_WB_en_out;
    wire [3:0]  EXE_stage_reg_file_dst_out, EXE_stage_SR_out;
    wire [31:0] EXE_stage_val_Rm_out, ALU_res;

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
        .Dest_in(ID_reg_reg_file_dst_out),
        .shifter_operand(ID_reg_shifter_operand_out),
        .signed_immediate(ID_reg_signed_immediate_out),
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

    wire        EXE_reg_mem_read_out, EXE_reg_mem_write_out, EXE_reg_WB_en_out;
    wire [3:0]  EXE_reg_dst_out;
    wire [31:0] EXE_reg_ALU_res_out, EXE_reg_val_Rm_out;

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

    wire        Mem_Stage_read_out, Mem_Stage_WB_en_out;
    wire [3:0]  Mem_Stage_dst_out;
    wire [31:0] Mem_Stage_ALU_res_out,  Mem_Stage_mem_out;

    MEM_Stage mem_stage(
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

    wire        Mem_Reg_read_out, Mem_Reg_WB_en_out;
    wire [3:0]  Mem_Reg_dst_out;
    wire [31:0] Mem_Reg_ALU_res_out, Mem_Reg_mem_out;

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

    wire      EXE_WB_en = ID_reg_WB_en_out, MEM_WB_en = EXE_reg_WB_en_out;
    wire[3:0] EXE_dest = ID_reg_reg_file_dst_out, MEM_dest = EXE_reg_dst_out;

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

