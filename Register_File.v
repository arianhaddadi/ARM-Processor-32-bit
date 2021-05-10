`include "constants.h"

module Register_File
(
    input                        clk,
    input                        rst,
    input                        WB_en,
    input  [`REG_FILE_DEPTH-1:0] WB_dest,
    input  [`REG_FILE_DEPTH-1:0] src1,
    input  [`REG_FILE_DEPTH-1:0] src2,
    input  [`WORD_WIDTH-1:0]     WB_result,
    
	output [`WORD_WIDTH-1:0]     reg1,
    output [`WORD_WIDTH-1:0]     reg2
);

  	reg [`WORD_WIDTH-1:0] registers [0:`REG_FILE_SIZE-1];
	integer i;
	always @(negedge clk, posedge rst)
	begin
		if (rst)
			begin
				for (i = 0; i < `REG_FILE_SIZE; i = i + 1)
					registers[i] <= i;
			end
		else
			begin
				if (WB_en) registers[WB_dest] <= WB_result;
			end
	end

	assign reg1 = registers[src1];
	assign reg2 = registers[src2];

endmodule
