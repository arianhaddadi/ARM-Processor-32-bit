`include "constants.h"

module ID_Reg
(
  input                                   clk,
  input                                   rst,
  input                                   Flush,
  input                                   MEM_R_EN_in, MEM_W_EN_in, WB_EN_in, Imm_in, 
  input                                   B_in, S_in,
  input [3:0] 												    EX_CMD_in,
  input [3:0]                             Status_Register_in,
  input [`REG_FILE_DEPTH-1:0] 				    Dest_in,
  input [`SIGNED_IMM_WIDTH-1:0] 			    signed_immediate_in,
  input [`SHIFTER_OPERAND_WIDTH-1:0]      shifter_operand_in,
  input [`WORD_WIDTH-1:0]                 PC_in,
  input [`WORD_WIDTH-1:0] 						    Val_Rn_in, Val_Rm_in,
  output reg                              MEM_R_EN_out, MEM_W_EN_out, WB_EN_out, Imm_out, 
  output reg                              B_out, S_out,
  output reg [3:0] 												EX_CMD_out,
  output reg [3:0]                        status_register_out,
  output reg [`SIGNED_IMM_WIDTH-1:0] 			signed_immediate_out,
  output reg [`SHIFTER_OPERAND_WIDTH-1:0] shifter_operand_out,
  output reg [`REG_FILE_DEPTH-1:0] 				Dest_out,
  output reg [`WORD_WIDTH-1:0]            PC_out,
  output reg [`WORD_WIDTH-1:0] 						Val_Rn_out, Val_Rm_out
);

  always @(posedge clk, posedge rst) begin
    if (rst || Flush) begin
      PC_out <= 0;
      Dest_out <= 0;
      Val_Rn_out <= 0;
      Val_Rm_out <=0;
      signed_immediate_out <= 0;
      shifter_operand_out <= 0;
      EX_CMD_out <= 0;
      status_register_out <= 0;
      MEM_R_EN_out <= 0;
      MEM_W_EN_out <= 0;
      WB_EN_out <= 0;
      Imm_out <= 0;
      B_out <= 0;
      S_out <= 0;
    end
    else begin
      PC_out <= PC_in;
      Dest_out <= Dest_in;
      Val_Rn_out <= Val_Rn_in;
      Val_Rm_out <= Val_Rm_in;
      signed_immediate_out <= signed_immediate_in;
      shifter_operand_out <= shifter_operand_in;
      EX_CMD_out <= EX_CMD_in;
      status_register_out <= Status_Register_in;
      MEM_R_EN_out <= MEM_R_EN_in;
      MEM_W_EN_out <= MEM_W_EN_in;
      WB_EN_out <= WB_EN_in;
      Imm_out <= Imm_in;
      B_out <= B_in;
      S_out <= S_in;
    end
  end

endmodule

