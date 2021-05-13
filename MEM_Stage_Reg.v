module MEM_Stage_Reg
(
    input                            clk,
    input                            rst,
    input                            MEM_R_EN_in,
    input                            WB_EN_in,
    input [3:0]                      Dest_in,
    input [31:0]                     ALU_Res_in,
    input [31:0]                     MEM_in,

    output reg                       MEM_R_EN_out,
    output reg                       WB_EN_out,
    output reg [3:0]                 Dest_out,
    output reg [31:0]                ALU_Res_out,
    output reg [31:0]                MEM_out
);

    always @(posedge clk, posedge rst) begin
        if(rst) begin
            MEM_R_EN_out <= 0;
            WB_EN_out <= 0;
            Dest_out <= 0;
            ALU_Res_out <= 0;
            MEM_out <= 0;
        end
        else begin
            MEM_R_EN_out <= MEM_R_EN_in;
            WB_EN_out <= WB_EN_in;
            Dest_out <= Dest_in;
            ALU_Res_out <= ALU_Res_in;
            MEM_out <= MEM_in;
        end
    end

endmodule
