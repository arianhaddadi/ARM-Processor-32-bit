module PC
(
    input                        clk,
    input                        rst,
    input                        Freeze,
    input      [31:0]            PC_in,

    output reg [31:0]            PC_out
);

    always @(posedge clk, posedge rst) begin
        if(rst) PC_out <= 0;
        else if(Freeze) PC_out <= PC_out;
        else PC_out <= PC_in;
    end
 
endmodule