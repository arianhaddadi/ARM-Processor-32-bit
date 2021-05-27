module IF_Stage
(
    input                    clk,
    input                    rst,
    input                    Freeze,
    input                    Branch_Taken,
    input  [31:0]            Branch_Address,
    
    output [31:0]            PC_Stage_out,
    output [31:0]            instruction
);

    wire [31:0] Adder_out, PC_out, MUX_out;

    assign PC_Stage_out = MUX_out;

    Instruction_Memory instruction_memory (
        .address(PC_out),
        .instruction(instruction)
    );

    Adder adder (
        .a(32'd1),
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
        .select(Branch_Taken),
        .inp1(Adder_out),
        .inp2(Branch_Address),
        .out(MUX_out)
    );
  
  
endmodule