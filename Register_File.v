module Register_File
(
    input             clk,
    input             rst,
    input             WB_EN,
    input  [3:0] 				 WB_Dest,
    input  [3:0] 				 src1,
    input  [3:0] 				 src2,
    input  [31:0]			  WB_Res,
    
	  output [31:0]			  reg1,
    output [31:0]			  reg2
);

 	reg [31:0] registers [0:14];
	assign reg1 = src1==4'b1111 ? 0 : registers[src1];
	assign reg2 = src2==4'b1111 ? 0 : registers[src2];
	
	integer i;
	always @(negedge clk, posedge rst) begin
		if (rst) begin
				for (i = 0; i < 15; i = i + 1)
					registers[i] <= 0;
		end
		else begin
				if (WB_EN) registers[WB_Dest] <= WB_Res;
		end
	end
endmodule
