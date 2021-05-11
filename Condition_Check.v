`include "constants.h"

module Condition_Check
(
    input  [3:0] condition,
    input  [3:0] Status_Register,

    output reg   state
);

    wire Z = Status_Register[3];
    wire C = Status_Register[2];
    wire N = Status_Register[1];
    wire V = Status_Register[0];

    parameter[3:0] EQ = 4'd0, NE = 4'd1, CS_HS = 4'd2, CC_LO = 4'd3, MI = 4'd4,
                    PL = 4'd5, VS = 4'd6, VC = 4'd7, HI = 4'd8, LS = 4'd9, GE = 4'd10, LT = 4'd11,
                    GT = 4'd12, LE = 4'd13, AL = 4'd14;

    always @(*) begin
        case(condition)
        EQ:    state = Z;
        NE:    state = ~Z;
        CS_HS: state = C;
        CC_LO: state = ~C;
        MI:    state = N;
        PL:    state = ~N;
        VS:    state = V;
        VC:    state = ~V;
        HI:    state = C & ~Z;
        LS:    state = ~C & Z;
        GE:    state = (N & V) | (~N & ~V);
        LT:    state = (N & ~V) | (~N & V);
        GT:    state = ~Z & ((N & V) | (~N & ~V));
        LE:    state = Z & ((N & ~V) | (~N & V));
        AL:    state = 1'b1;
        endcase
    end

endmodule
