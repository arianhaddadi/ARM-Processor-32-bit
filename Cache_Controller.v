`timescale 1ns/1ns

module Cache_Controller (
    input              clk,
    input              rst,
    input              MEM_W_EN,
    input              MEM_R_EN,
    input              SRAM_Ready,
    input              Cache_Hit,
    input    [31:0]    address,
    input    [31:0]    writeData,
    input    [63:0]    SRAM_Read_Data,
    input    [31:0]    CacheReadData,
    
    output             ready,
    output             Cache_WE,
    output             Cache_RE,
    output             SRAM_WE,  
    output             SRAM_RE,
    output             checkInvalidation,
    output   [16:0]    CacheAddress, 
    output   [31:0]    SRAM_Adress, 
    output   [31:0]    SRAM_Write_Data,
    output   [31:0]    readData,
    output   [63:0]    CacheWriteData
);

   	wire isCacheReadSuccessful, isMissOperationDone, isInSramRead, isSramWriteDone;
    wire [31:0] generatedAddr;
    reg [1:0] PS, NS;
    parameter IdleOrCacheRead=2'b00, SramReadAndCacheWrite=2'b01, SramWrite=2'b10;

    assign generatedAddr = {address[31:2], 2'b00} - 32'd1024;
    assign CacheAddress = generatedAddr[18:2];
    assign isCacheReadSuccessful = (PS == IdleOrCacheRead) && MEM_R_EN && Cache_Hit;
    assign isMissOperationDone = (PS == SramReadAndCacheWrite) && SRAM_Ready;
    assign isSramWriteDone = (PS == SramWrite) && SRAM_Ready;
    assign isInSramRead = PS == SramReadAndCacheWrite;
    assign SRAM_Write_Data = SRAM_WE ? writeData : 32'b0;
    assign Cache_RE = (PS == IdleOrCacheRead) && MEM_R_EN;
    assign Cache_WE = isMissOperationDone;
    assign CacheWriteData = isMissOperationDone ? SRAM_Read_Data : 64'b0;
    assign SRAM_WE = PS == SramWrite;
    assign checkInvalidation = (PS == IdleOrCacheRead) && MEM_W_EN;
    assign SRAM_RE = isInSramRead;
    assign SRAM_Adress = address;
    assign ready = (~MEM_W_EN && ~MEM_R_EN) || isMissOperationDone || isCacheReadSuccessful || isSramWriteDone;
    assign readData = isCacheReadSuccessful ? CacheReadData : 
                      (isMissOperationDone ? (CacheAddress[0] ? SRAM_Read_Data[63:32] : SRAM_Read_Data[31:0]) : 32'b0);
                
    
    always @(posedge clk, posedge rst) begin
      if(rst) PS <= IdleOrCacheRead;
      else PS <= NS;
    end
    
    always @(*) begin
      if(PS == IdleOrCacheRead) begin
        if(MEM_R_EN) NS = Cache_Hit ? IdleOrCacheRead : SramReadAndCacheWrite;
        else if(MEM_W_EN) NS = SramWrite;
        else NS = IdleOrCacheRead;
      end
      else if(PS == SramReadAndCacheWrite) begin
        NS = SRAM_Ready ? IdleOrCacheRead : SramReadAndCacheWrite;
      end
      else if(PS == SramWrite) begin
        NS = SRAM_Ready ? IdleOrCacheRead : SramWrite;
      end
    end

endmodule
