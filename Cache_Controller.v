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
    input    [31:0]    SRAM_Read_Data,
    input    [31:0]    CacheReadData,
    
    output             ready,
    output             Cache_WE,
    output             Cache_RE,
    output             SRAM_WE,  
    output             SRAM_RE,
    output   [16:0]    CacheAddress, 
    output   [31:0]    SRAM_Adress, 
    output   [31:0]    SRAM_Write_Data,
    output   [31:0]    readData,
    output   [63:0]    CacheWriteData
);

   	wire isCacheReadSuccessful, isMissOperationDone, isInSramRead1, isInSramRead2, isSramWriteDone;
    wire [31:0] generatedAddr, cacheWiteDataSecondHalf;
    reg [1:0] PS, NS;
    reg [31:0] cacheWiteDataFirstHalf;
    parameter IdleOrCacheRead=2'b00, SramRead1=2'b01, SramRead2AndCacheWrite=2'b10, SramWrite=2'b11;

    assign generatedAddr = {address[31:2], 2'b00} - 32'd1024;
    assign CacheAddress = generatedAddr[18:2];
    assign isCacheReadSuccessful = (PS == IdleOrCacheRead) && MEM_R_EN && Cache_Hit;
    assign isMissOperationDone = (PS == SramRead2AndCacheWrite) && SRAM_Ready;
    assign isSramWriteDone = (PS == SramWrite) && SRAM_Ready;
    assign isInSramRead1 = ((PS == IdleOrCacheRead) && MEM_R_EN && ~Cache_Hit) || (PS == SramRead1);
    assign isInSramRead2 = ((PS == SramRead1) && SRAM_Ready) || (PS == SramRead2AndCacheWrite);
    assign SRAM_Write_Data = SRAM_WE ? writeData : 32'b0;
    assign Cache_RE = (PS == IdleOrCacheRead) && MEM_R_EN;
    assign Cache_WE = isMissOperationDone;
    assign cacheWiteDataSecondHalf = isMissOperationDone ? SRAM_Read_Data : 32'b0;
    assign CacheWriteData = isMissOperationDone ? {cacheWiteDataSecondHalf, cacheWiteDataFirstHalf} : 64'b0;
    assign SRAM_WE = ((PS == IdleOrCacheRead) && MEM_W_EN) ||  (PS == SramWrite);
    assign SRAM_RE = isInSramRead1 || isInSramRead2;
    assign ready = (~MEM_W_EN && ~MEM_R_EN) || isMissOperationDone || isCacheReadSuccessful || isSramWriteDone;
    assign readData = isCacheReadSuccessful ? CacheReadData : 
                      (isMissOperationDone ? (CacheAddress[0] ? cacheWiteDataSecondHalf : cacheWiteDataFirstHalf) : 32'b0);
    assign SRAM_Adress = isInSramRead1 ? {address[31:3], 1'b0, address[1:0]} :
                        (isInSramRead2 ? {address[31:3], 1'b1, address[1:0]} : address);
                         
    
    always @(posedge clk, posedge rst) begin
      if(rst) begin
        PS <= IdleOrCacheRead;
        cacheWiteDataFirstHalf <= 32'b0;
      end
      else begin
        PS <= NS;
        if((PS == SramRead1) && SRAM_Ready) cacheWiteDataFirstHalf <= SRAM_Read_Data;
      end
    end
    
    
    always @(*) begin
      if(PS == IdleOrCacheRead) begin
        if(MEM_R_EN) NS = Cache_Hit ? IdleOrCacheRead : SramRead1;
        else if(MEM_W_EN) NS = SramWrite;
        else NS = IdleOrCacheRead;
      end
      else if(PS == SramRead1) begin
        NS = SRAM_Ready ? SramRead2AndCacheWrite : SramRead1;
      end
      else if(PS == SramRead2AndCacheWrite) begin
        NS = SRAM_Ready ? IdleOrCacheRead : SramRead2AndCacheWrite;
      end
      else if(PS == SramWrite) begin
        NS = SRAM_Ready ? IdleOrCacheRead : SramWrite;
      end
    end

endmodule
