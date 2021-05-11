`include "constants.h"

module Control_Unit
(
    input            S,
    input      [1:0] mode,
    input      [3:0] OP,
    
    output           SR_update,
    output           with_src1,
    output reg       MEM_R,
    output reg       MEM_W,
    output reg       WB_EN,
    output reg       B,
    output reg [3:0] EX_CMD
);

    always @(*) begin
        MEM_R = 0;
        MEM_W = 0;
        WB_EN = 0;
        B = 0;
        case (mode)
            `MODE_MEM: begin
                case (S)
                    0: begin
                        EX_CMD = `EX_STR;
                        MEM_W = 1;
                    end

                    1: begin
                        EX_CMD = `EX_LDR;
                        MEM_R = 1;
                        WB_EN = 1;
                    end
                endcase
            end

            `MODE_ARITHMETIC: begin
                case (OP)
                    `OP_MOV: begin
                        EX_CMD = `EX_MOV;
                        WB_EN = 1;
                    end

                    `OP_MVN: begin
                        EX_CMD = `EX_MVN;
                        WB_EN = 1;
                    end

                    `OP_ADD: begin
                        EX_CMD = `EX_ADD;
                        WB_EN = 1;
                    end

                    `OP_ADC: begin
                        EX_CMD = `EX_ADC;
                        WB_EN = 1;
                    end

                    `OP_SUB: begin
                        EX_CMD = `EX_SUB;
                        WB_EN = 1;
                    end

                    `OP_SBC: begin
                        EX_CMD = `EX_SBC;
                        WB_EN = 1;
                    end
                    `OP_AND: begin
                        EX_CMD = `EX_AND;
                        WB_EN = 1;
                    end

                    `OP_ORR: begin
                        EX_CMD = `EX_ORR;
                        WB_EN = 1;
                    end

                    `OP_EOR: begin
                        EX_CMD = `EX_EOR;
                        WB_EN = 1;
                    end

                    `OP_CMP: EX_CMD = `EX_CMP;
                    `OP_TST: EX_CMD = `EX_TST;
                endcase
            end

            `MODE_BRANCH: B = 1;
        endcase
    end

    assign with_src1 = (EX_CMD == `EX_MOV || EX_CMD == `EX_MOV || B) ? 1'b0 : 1'b1;
    assign SR_update = S;

endmodule
