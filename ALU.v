`define EXE_MOV 4'b0001
`define EXE_MVN 4'b1001
`define EXE_ADD 4'b0010
`define EXE_ADC 4'b0011
`define EXE_SUB 4'b0100
`define EXE_SBC 4'b0101
`define EXE_AND 4'b0110
`define EXE_ORR 4'b0111
`define EXE_EOR 4'b1000
`define EXE_CMP 4'b1100
`define EXE_TST 4'b1110
`define EXE_LDR 4'b1010
`define EXE_STR 4'b1010


module ALU
(
    input          carry,
    input [3:0]    EXE_CMD,
    input [31:0]   val1,
    input [31:0]   val2,
    
    output [3:0]   SR,
    output [31:0]  result
);

    reg V1, C1;
    reg [32:0] temp_result;
    
    wire N1, Z1;

    assign result = temp_result[31:0];
    assign SR = {Z1, C1, N1, V1};

    assign N1 = result[31];
    assign Z1 = |result ? 0:1;

    always @(*) begin
        V1 = 1'b0;
        C1 = 1'b0;
        case (EXE_CMD)
            `EXE_MOV: temp_result = val2;
            `EXE_MVN: temp_result = ~val2;
            `EXE_ADD: begin
                temp_result = val1 + val2;
                C1 = temp_result[32];
                V1 = (val1[31] ~^ val2[31]) & (temp_result[31] ^ val1[31]);
            end
            `EXE_ADC: begin
                temp_result = val1 + val2 + carry;
                C1 = temp_result[32];
                V1 = (val1[31] ~^ val2[31]) & (temp_result[31] ^ val1[31]);
            end
            `EXE_SUB: begin
                temp_result = {val1[31], val1} - {val2[31], val2};
                C1 = temp_result[32];
                V1 = (val1[31] ^ val2[31]) & (temp_result[31] ^ val1[31]);
            end
            `EXE_SBC: begin
                temp_result = val1 - val2 - 2'b01;
                C1 = temp_result[32];
                V1 = (val1[31] ^ val2[31]) & (temp_result[31] ^ val1[31]);
            end
            `EXE_AND: temp_result = val1 & val2;
            `EXE_ORR: temp_result = val1 | val2;
            `EXE_EOR: temp_result = val1 ^ val2;
            `EXE_CMP: begin
                temp_result = {val1[31], val1} - {val2[31], val2};
                C1 = temp_result[32];
                V1 = (val1[31] ^ val2[31]) & (temp_result[31] ^ val1[31]);
            end
            `EXE_TST: temp_result = val1 & val2;
            `EXE_LDR: temp_result = val1 + val2;
            `EXE_STR: temp_result = val1 - val2;
            default: temp_result = 3'bx;

        endcase
    end

endmodule