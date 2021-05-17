module Forwarding_Unit (
    input isForwardingActive,
    input  [3:0] src1,
    input  [3:0] src2,
    input  [3:0] MEM_Dest,
    input  [3:0] WB_Dest,
    input        MEM_WB_EN,
    input        WB_WB_EN,
    output reg [1:0] Alu_Src1_Sel,
    output reg [1:0] Alu_Src2_Sel
);

  always @(*) begin
    Alu_Src1_Sel = 2'b00;
    Alu_Src2_Sel = 2'b00;
    if(isForwardingActive) begin
        if ((MEM_WB_EN == 1'b1) && (src1 == MEM_Dest))
            Alu_Src1_Sel = 2'b01;
        else if ((WB_WB_EN == 1'b1) && (src1 == WB_Dest))
            Alu_Src1_Sel = 2'b10;
            
        if ((MEM_WB_EN == 1'b1) && (src2 == MEM_Dest))
            Alu_Src2_Sel = 2'b01;
        else if ((WB_WB_EN == 1'b1) && (src2 == WB_Dest))
            Alu_Src2_Sel = 2'b10;
    end
  end

endmodule
