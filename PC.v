`include "constants.h"

module PC
(
    input                        clk,
    input                        rst,
    input                        Freeze,
    input      [`WORD_WIDTH-1:0] PC_in,
    output reg [`WORD_WIDTH-1:0] PC_out
);

always @(posedge clk or posedge rst) begin
  if(rst) PC_out <= 0;
  else if(~Freeze) PC_out <= PC_in;
  else PC_out <= PC_out;
end
 
endmodule