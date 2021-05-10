`include "constants.h"

module Condition_Check
(
    input  [3:0] condition,
    input  [3:0] Status_Register,

    output reg   condition_state
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
        EQ:    condition_state = Z;
        NE:    condition_state = ~Z;
        CS_HS: condition_state = C;
        CC_LO: condition_state = ~C;
        MI:    condition_state = N;
        PL:    condition_state = ~N;
        VS:    condition_state = V;
        VC:    condition_state = ~V;
        HI:    condition_state = C & ~Z;
        LS:    condition_state = ~C & Z;
        GE:    condition_state = (N & V) | (~N & ~V);
        LT:    condition_state = (N & ~V) | (~N & V);
        GT:    condition_state = ~Z & ((N & V) | (~N & ~V));
        LE:    condition_state = Z & ((N & ~V) | (~N & V));
        AL:    condition_state = 1'b1;
        endcase
    end

endmodule
