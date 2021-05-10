`include "constants.h"

module Status_Reg
(
    input            clk,
    input            rst,
    input            load,
    input      [3:0] status_in,
    
    output reg [3:0] status_out
);

always @(negedge clk, posedge rst) begin
  if(rst) status_out <= 0;
  else if(load) status_out <= status_in;
  else status_out <= status_out;
end
 
endmodule
