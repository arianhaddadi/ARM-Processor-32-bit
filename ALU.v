`include "constants.h"

module ALU
(
    input                           carry,
    input       [3:0]               EXE_CMD,
    input       [`WORD_WIDTH-1:0]   val1,
    input       [`WORD_WIDTH-1:0]   val2,
    
    output      [3:0]               SR,
    output      [`WORD_WIDTH-1:0]   result
);

    reg V1, C1;
    reg [`WORD_WIDTH:0] temp_result;
    
    wire N1, Z1;

    assign result = temp_result[`WORD_WIDTH-1:0];
    assign SR = {Z1, C1, N1, V1};

    assign N1 = result[`WORD_WIDTH-1];
    assign Z1 = |result ? 0:1;

    always @(*) begin
        V1 = 1'b0;
        C1 = 1'b0;
        case (EXE_CMD)
            `EX_MOV: temp_result = val2;
            `EX_MVN: temp_result = ~val2;
            `EX_ADD: begin
                temp_result = val1 + val2;
                C1 = temp_result[`WORD_WIDTH];
                V1 = (val1[`WORD_WIDTH-1] ~^ val2[`WORD_WIDTH-1]) & (temp_result[`WORD_WIDTH-1] ^ val1[`WORD_WIDTH-1]);
            end
            `EX_ADC: begin
                temp_result = val1 + val2 + carry;
                C1 = temp_result[`WORD_WIDTH];
                V1 = (val1[`WORD_WIDTH-1] ~^ val2[`WORD_WIDTH-1]) & (temp_result[`WORD_WIDTH-1] ^ val1[`WORD_WIDTH-1]);
            end
            `EX_SUB: begin
                temp_result = {val1[`WORD_WIDTH-1], val1} - {val2[`WORD_WIDTH-1], val2};
                C1 = temp_result[`WORD_WIDTH];
                V1 = (val1[`WORD_WIDTH-1] ^ val2[`WORD_WIDTH-1]) & (temp_result[`WORD_WIDTH-1] ^ val1[`WORD_WIDTH-1]);
            end
            `EX_SBC: begin
                temp_result = val1 - val2 - 2'b01;
                C1 = temp_result[`WORD_WIDTH];
                V1 = (val1[`WORD_WIDTH-1] ^ val2[`WORD_WIDTH-1]) & (temp_result[`WORD_WIDTH-1] ^ val1[`WORD_WIDTH-1]);
            end
            `EX_AND: temp_result = val1 & val2;
            `EX_ORR: temp_result = val1 | val2;
            `EX_EOR: temp_result = val1 ^ val2;
            `EX_CMP: begin
                temp_result = {val1[`WORD_WIDTH-1], val1} - {val2[`WORD_WIDTH-1], val2};
                C1 = temp_result[`WORD_WIDTH];
                V1 = (val1[`WORD_WIDTH-1] ^ val2[`WORD_WIDTH-1]) & (temp_result[`WORD_WIDTH-1] ^ val1[`WORD_WIDTH-1]);
            end
            `EX_TST: temp_result = val1 & val2;
            `EX_LDR: temp_result = val1 + val2;
            `EX_STR: temp_result = val1 - val2;
            default: temp_result = 3'bx;

        endcase
    end

endmodule