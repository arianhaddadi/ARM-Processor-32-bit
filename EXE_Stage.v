`include "constants.h"

module EXE_Stage
(
  input                               clk,
  input                               rst,
  input                               mem_read_in, mem_write_in, imm, WB_en_in, B_in,
  input  [3:0]                        EX_command,
  input  [3:0]                        SR_in,
  input  [`SIGNED_IMM_WIDTH-1:0]      signed_immediate,
  input  [`SHIFTER_OPERAND_WIDTH-1:0] shifter_operand,
  input  [`REG_FILE_DEPTH-1:0]        dst_in,
  input  [`WORD_WIDTH-1:0]            pc_in,
  input  [`WORD_WIDTH-1:0]            val_Rn_in, val_Rm_in,
  output                              mem_read_out, mem_write_out, WB_en_out, B_out,
  output [3:0]                        SR_out,
  output [`REG_FILE_DEPTH-1:0]        dst_out,
  output [`WORD_WIDTH-1:0]            ALU_res,
  output [`WORD_WIDTH-1:0]            val_Rm_out,
  output [`WORD_WIDTH-1:0]            branch_address
);

  wire [`WORD_WIDTH-1:0] val2;
  wire is_for_memory;

  Adder adder(
    .a(pc_in),
    .b({{(8){signed_immediate[`SIGNED_IMM_WIDTH-1]}}, signed_immediate}),
    .out(branch_address)
  );

  Val2_Generate val2_generate(
    .val_Rm(val_Rm_in),
    .shifter_operand(shifter_operand),
    .imm(imm),
    .is_for_memory(is_for_memory),
    .val2_out(val2)
	);

  ALU alu(
    .val1(val_Rn_in),
    .val2(val2),
    .EX_command(EX_command),
    .carry(SR_in[2]),
    .res(ALU_res),
    .SR(SR_out)
  );

  assign is_for_memory = mem_read_in | mem_write_in;
  assign dst_out = dst_in;
	assign mem_read_out = mem_read_in;
	assign mem_write_out = mem_write_in;
  assign WB_en_out = WB_en_in;
  assign B_out = B_in;
  assign val_Rm_out = val_Rm_in;

endmodule
