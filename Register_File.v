module Register_File
(
    input                        clk,
    input                        rst,
    input                        WB_EN,
    input  [3:0] 				 WB_Dest,
    input  [3:0] 				 src1,
    input  [3:0] 				 src2,
    input  [31:0]			     WB_Res,
    
	output [31:0]			     reg1,
    output [31:0]			     reg2
);

  	reg [31:0] registers [0:15];
	assign reg1 = registers[src1];
	assign reg2 = registers[src2];
	
	integer i;
	always @(negedge clk, posedge rst) begin
		if (rst) begin
				for (i = 0; i < 16; i = i + 1)
					registers[i] <= i;
		end
		else begin
				if (WB_EN) registers[WB_Dest] <= WB_Res;
		end
	end


endmodule
