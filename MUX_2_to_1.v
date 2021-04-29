`include "constants.h"

module MUX_2_to_1
(
  input                        sel,
  input      [`WORD_WIDTH-1:0] in1, in2,
  output reg [`WORD_WIDTH-1:0] out
);

  always@(sel or in1 or in2) begin
    out = 0;
    case(sel)
      1'd0: out = in1;
      1'd1: out = in2;
      default: out = 0;
    endcase
  end

endmodule