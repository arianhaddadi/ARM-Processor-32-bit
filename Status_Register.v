`include "constants.h"

module Status_Register
(
    input            clk,
    input            rst,
    input            S,
    input      [3:0] status_in,

    output reg [3:0] status_out
);

    always @(negedge clk, posedge rst) begin
        if(rst) status_out <= 0;
        else if(S) status_out <= status_in;
        else status_out <= status_out;
    end

endmodule
