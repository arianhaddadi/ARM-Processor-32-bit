module Hazard_Detection_Unit (
    input                        EXE_WB_EN,
    input                        MEM_WB_EN,
    input                        with_src1,
    input                        with_src2,
    input  [3:0]                 src1,
    input  [3:0]                 src2,
    input  [3:0]                 EXE_Dest,
    input  [3:0]                 MEM_Dest,

    output reg                   has_hazard
);

    always @(*) begin
        if (    ((src1 == EXE_Dest) && (EXE_WB_EN) && (with_src1)) ||
                ((src1 == MEM_Dest) && (MEM_WB_EN) && (with_src1)) ||
                ((src2 == MEM_Dest) && (MEM_WB_EN) && (with_src2)) ||
                ((src2 == EXE_Dest) && (EXE_WB_EN) && (with_src2)) 
            ) has_hazard = 1'b1;
        else has_hazard = 1'b0;
    end

endmodule

