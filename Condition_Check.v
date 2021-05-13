module Condition_Check
(
    input  [3:0] condition,
    input  [3:0] Status_Register,

    output reg   state
);

    wire V = Status_Register[0];
    wire N = Status_Register[1];
    wire C = Status_Register[2];
    wire Z = Status_Register[3];

    always @(*) begin
        case(condition)
        4'd0:    state = Z;
        4'd1:    state = ~Z;
        4'd2:    state = C;
        4'd3:    state = ~C;
        4'd4:    state = N;
        4'd5:    state = ~N;
        4'd6:    state = V;
        4'd7:    state = ~V;
        4'd8:    state = C & ~Z;
        4'd9:    state = ~C & Z;
        4'd10:   state = (N & V) | (~N & ~V);
        4'd11:   state = (N & ~V) | (~N & V);
        4'd12:   state = ~Z & ((N & V) | (~N & ~V));
        4'd13:   state = Z & ((N & ~V) | (~N & V));
        4'd14:   state = 1'b1;
        endcase
    end

endmodule
