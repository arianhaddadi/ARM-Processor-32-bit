`include "constants.h"

module IF_Reg
(
    input                        clk,
    input                        rst,
    input                        Freeze,
    input                        Flush,
    input      [`WORD_WIDTH-1:0] PC_in,
    input      [`WORD_WIDTH-1:0] instruction_in,
    output reg [`WORD_WIDTH-1:0] PC_out,
    output reg [`WORD_WIDTH-1:0] instruction_out
);

always @(posedge clk or posedge rst) begin

  if(rst) begin
    instruction_out <= 0;
    PC_out <= 0;
  end
  else if(Flush) begin
    instruction_out <= 0;
    PC_out <= 0;
  end
  else if(~Freeze) begin
    instruction_out <= instruction_in;
    PC_out <= PC_in;
  end
  else begin
    instruction_out <= instruction_in;
    PC_out <= PC_out;
  end  

end
 

endmodule