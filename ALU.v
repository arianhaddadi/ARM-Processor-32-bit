`define EXE_MOV 4'b0001
`define EXE_MVN 4'b1001
`define EXE_ADD 4'b0010
`define EXE_ADC 4'b0011
`define EXE_SUB 4'b0100
`define EXE_SBC 4'b0101
`define EXE_AND 4'b0110
`define EXE_ORR 4'b0111
`define EXE_EOR 4'b1000
`define EXE_CMP 4'b0100
`define EXE_TST 4'b0110
`define EXE_LDR 4'b0010
`define EXE_STR 4'b0010


module ALU
(
    input          carry,
    input [3:0]    EXE_CMD,
    input [31:0]   val1,
    input [31:0]   val2,
    
    output [3:0]   SR,
    output [31:0]  result
);

    reg V, C;
    reg [32:0] temp;
    
    wire N, Z;

    assign result = temp[31:0];
    assign SR = {Z, C, N, V};

    assign N = result[31];
    assign Z = result==0;

    always @(*) begin
        V = 1'b0;
        C = 1'b0;
        temp = 33'b0;
        case (EXE_CMD)
            `EXE_MOV: temp = val2;
            `EXE_MVN: temp = ~val2;
            `EXE_ADD: begin
                temp = val1 + val2;
                V = (val1[31] ~^ val2[31]) & (temp[31] ^ val1[31]);
                C = temp[32];
            end
            `EXE_ADC: begin
                temp = val1 + val2 + carry;
                V = (val1[31] ~^ val2[31]) & (temp[31] ^ val1[31]);
                C = temp[32];
            end
            `EXE_SUB: begin
                temp = {val1[31], val1} - {val2[31], val2};
                V = (val1[31] ^ val2[31]) & (temp[31] ^ val1[31]);
                C = temp[32];
            end
            `EXE_SBC: begin
                temp = val1 - val2 - {32{~carry}};
                V = (val1[31] ^ val2[31]) & (temp[31] ^ val1[31]);
                C = temp[32];
            end
            `EXE_AND: temp = val1 & val2;
            `EXE_ORR: temp = val1 | val2;
            `EXE_EOR: temp = val1 ^ val2;
            `EXE_CMP: begin
                temp = {val1[31], val1} - {val2[31], val2};
                V = (val1[31] ^ val2[31]) & (temp[31] ^ val1[31]);
                C = temp[32];
            end
            `EXE_TST: temp = val1 & val2;
            `EXE_LDR: temp = val1 + val2;
            `EXE_STR: temp = val1 + val2;
            default: begin
              temp = 33'b0;
              V = 1'b0;
              C = 1'b0;
            end

        endcase
    end

endmodule