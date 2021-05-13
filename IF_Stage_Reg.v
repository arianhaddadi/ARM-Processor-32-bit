module IF_Stage_Reg
(
    input                        clk,
    input                        rst,
    input                        Freeze,
    input                        Flush,
    input      [31:0]            PC_in,
    input      [31:0]            instruction_in,

    output reg [31:0]            instruction_out,
    output reg [31:0]            PC_out
);

    always @(posedge clk, posedge rst) begin

        if(rst) begin
            instruction_out <= 0;
            PC_out <= 0;
        end
        else if(Flush) begin
            instruction_out <= 0;
            PC_out <= 0;
        end
        else if(Freeze) begin
            instruction_out <= instruction_out;
            PC_out <= PC_out;
        end  
        else begin
            instruction_out <= instruction_in;
            PC_out <= PC_in;
        end

    end
 

endmodule