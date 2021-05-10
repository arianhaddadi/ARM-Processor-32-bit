`include "constants.h"

module IF_Stage
(
    input                    clk,
    input                    rst,
    input                    Freeze,
    input                    Branch_Taken,
    input  [`WORD_WIDTH-1:0] Branch_Address,
    
    output [`WORD_WIDTH-1:0] PC_Stage_out,
    output [`WORD_WIDTH-1:0] instruction
);

  wire [`WORD_WIDTH-1:0] Adder_out;
  wire [`WORD_WIDTH-1:0] PC_out;
  wire [`WORD_WIDTH-1:0] MUX_out;
  
  assign PC_Stage_out = MUX_out;
  
  Instruction_Memory instruction_memory (
   .address(PC_out),
   .instruction(instruction)
  );

  Adder adder (
   .a(32'b01),
   .b(PC_out),
   .out(Adder_out)
  );


  PC pc (
   .clk(clk),
   .rst(rst),
   .Freeze(Freeze),
   .PC_in(MUX_out),
   .PC_out(PC_out)
  );

  MUX_2_to_1 mux_2_to_1 (
   .sel(Branch_Taken),
   .in1(Adder_out),
   .in2(Branch_Address),
   .out(MUX_out)
  );
  
  
endmodule