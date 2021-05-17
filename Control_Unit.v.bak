
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

`define OP_MOV 4'b1101
`define OP_MVN 4'b1111
`define OP_ADD 4'b0100
`define OP_ADC 4'b0101
`define OP_SUB 4'b0010
`define OP_SBC 4'b0110
`define OP_AND 4'b0000
`define OP_ORR 4'b1100
`define OP_EOR 4'b0001
`define OP_CMP 4'b1010
`define OP_TST 4'b1000
`define OP_LDR 4'b0100
`define OP_STR 4'b0100


module Control_Unit
(
    input            S,
    input      [1:0] mode,
    input      [3:0] OP,
    
    output           S_out,
    output reg       MEM_R,
    output reg       MEM_W,
    output reg       WB_EN,
    output reg       B,
    output reg [3:0] EXE_CMD
);

    always @(*) begin
        MEM_R = 0;
        MEM_W = 0;
        WB_EN = 0;
        B = 0;
        case (mode)
            2'b01: begin // memory mode
                case (S)
                    0: begin
                        EXE_CMD = `EXE_STR;
                        MEM_W = 1;
                    end

                    1: begin
                        EXE_CMD = `EXE_LDR;
                        MEM_R = 1;
                        WB_EN = 1;
                    end
                endcase
            end

            2'b00: begin // arithmetic mode
                case (OP)
                    `OP_MOV: begin
                        EXE_CMD = `EXE_MOV;
                        WB_EN = 1;
                    end

                    `OP_MVN: begin
                        EXE_CMD = `EXE_MVN;
                        WB_EN = 1;
                    end

                    `OP_ADD: begin
                        EXE_CMD = `EXE_ADD;
                        WB_EN = 1;
                    end

                    `OP_ADC: begin
                        EXE_CMD = `EXE_ADC;
                        WB_EN = 1;
                    end

                    `OP_SUB: begin
                        EXE_CMD = `EXE_SUB;
                        WB_EN = 1;
                    end

                    `OP_SBC: begin
                        EXE_CMD = `EXE_SBC;
                        WB_EN = 1;
                    end
                    `OP_AND: begin
                        EXE_CMD = `EXE_AND;
                        WB_EN = 1;
                    end

                    `OP_ORR: begin
                        EXE_CMD = `EXE_ORR;
                        WB_EN = 1;
                    end

                    `OP_EOR: begin
                        EXE_CMD = `EXE_EOR;
                        WB_EN = 1;
                    end

                    `OP_CMP: EXE_CMD = `EXE_CMP;
                    `OP_TST: EXE_CMD = `EXE_TST;
                endcase
            end

            2'b10: B = 1; // branch mode
        endcase
    end

    assign S_out = S;

endmodule
