module Adder (
	input  [31:0]  a,
	input  [31:0]  b, 

	output [31:0]  out
);
  
	reg [31:0] result;
	
	always@(*) begin
		result = a + b;     
	end
	
	assign out = result;
  
endmodule