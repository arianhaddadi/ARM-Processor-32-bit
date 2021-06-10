`timescale 1ns/1ns

module SRAM_Controller (
    input              clk,
    input              rst,
    input              MEM_W_EN,
    input              MEM_R_EN,
    input    [31:0]    address,
    input    [31:0]    writeData, 
    
    output             ready,
    output             SRAM_UB_N,
    output             SRAM_LB_N,
    output             SRAM_WE_N,
    output             SRAM_CE_N,
    output             SRAM_OE_N,    
    output   [16:0]    SRAM_ADDR, 
    output   [63:0]    readData,
    
    inout    [63:0]    SRAM_DQ
);

    reg [2:0] counter;
    reg [64:0] sram_read_data;
    
    wire isInSramWrite;
    wire [31:0] generatedAddr = {address[31:2], 2'b00} - 32'd1024;

    assign {SRAM_UB_N, SRAM_LB_N, SRAM_CE_N, SRAM_OE_N} = 4'b0000;
    assign readData = sram_read_data;
    assign SRAM_ADDR = generatedAddr[18:2];
    assign ready = (~MEM_W_EN && ~MEM_R_EN) || (counter == 3'd5);
    assign isInSramWrite = MEM_W_EN && (counter < 3'd3);
    assign SRAM_DQ = isInSramWrite ? {32'b0, writeData} : 64'bz;
    assign SRAM_WE_N = ~isInSramWrite;
    
    always @(posedge clk, posedge rst) begin
        if(rst) begin
          sram_read_data <= 64'b0;
          counter <= 3'b0;
        end

        if((MEM_W_EN || MEM_R_EN) && (counter != 3'd5)) counter <= counter + 3'd1;
        else counter <= 3'b0;
        
        if (MEM_R_EN && (counter == 3'd3)) begin
            sram_read_data <= SRAM_DQ;
        end
    end


endmodule