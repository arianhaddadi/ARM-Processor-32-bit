module Val2_Generate
(
    input                   I,
    input                   for_mem,
    input      [11:0]       shifter_operand,
    input      [31:0]       Val_Rm,
    
    output reg [31:0]       Val2_out
);

    reg [31:0]  immd_temp;

    integer i;
    always @(*) begin
        if(for_mem) Val2_out = {20'b0, shifter_operand};
        else if(I) begin
            immd_temp = {24'b0, shifter_operand[7:0]};

            for (i = 0; i < {shifter_operand[11:8], 1'b0}; i = i + 1) begin
                immd_temp = {immd_temp[0], immd_temp[31:1]};
            end
            Val2_out = immd_temp;
        end

        else begin
            case (shifter_operand[6:5])
                00: Val2_out = Val_Rm << shifter_operand[11:7];
                01: Val2_out = Val_Rm >> shifter_operand[11:7];
                10: Val2_out = Val_Rm >>> shifter_operand[11:7];
                11: begin
                    Val2_out = Val_Rm;
                    for (i = 0; i < {shifter_operand[11:7]}; i = i + 1) begin
                        Val2_out = {Val2_out[0], Val2_out[31:1]};
                    end
                end
                default: Val2_out = Val_Rm << shifter_operand[11:7];
            endcase
        end

    end

endmodule
