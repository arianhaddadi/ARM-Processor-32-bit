module MUX_2_to_1
(
    select,
    inp1,
    inp2,
    out
);

    parameter                    WORD_WIDTH = 32;
    input                        select;
    input      [31:0]            inp1, inp2;
    output reg [31:0]            out;

    always @(select, inp1, inp2) begin
        out = 0;

        case(select)
            1'd0: out = inp1;
            1'd1: out = inp2;
            default: out = 0;
        endcase
        
    end

endmodule