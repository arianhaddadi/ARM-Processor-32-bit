`timescale 1ns/1ns

module Cache (
    input             clk,
    input             rst,
    input             Cache_WE,
    input             Cache_RE,
    input             SRAM_WE,
    input    [16:0]   CacheAddress,
    input    [63:0]   CacheWriteData,
    output            hit,
    output   [31:0]   readData       
);

    wire [5:0] index;
    wire [9:0] tag;
    wire offset;
    wire set1_hit;
    wire set2_hit;
    
    reg [31:0] set1_data  [0:63][0:1];
    reg [31:0] set2_data  [0:63][0:1];
    reg [9:0]  set1_tag   [0:63];
    reg [9:0]  set2_tag   [0:63];
    reg        set1_valid [0:63];
    reg        set2_valid [0:63];
    reg        cache_lru  [0:63];
    
    assign index  =  CacheAddress[6:1];
    assign tag    =  CacheAddress[16:7];
    assign offset =  CacheAddress[0];
    assign set1_hit = (tag == set1_tag[index]) && set1_valid[index];
    assign set2_hit = (tag == set2_tag[index]) && set2_valid[index];
    assign hit = set1_hit || set2_hit;
    assign readData = set1_hit ? set1_data[index][offset] : (
                      set2_hit ? set2_data[index][offset] : 32'b0);

    always @(*) begin
      if(SRAM_WE) begin
        if(set1_hit) begin
          set1_valid[index] = 1'b0;
          cache_lru[index] = 1'b1;
        end
        else if(set2_hit) begin
          set2_valid[index] = 1'b0;
          cache_lru[index] = 1'b0;
        end
      end
    end

    integer i;
    always @(posedge clk, posedge rst) begin
        if (rst) begin
				  for (i = 0; i < 64; i = i + 1) begin
					   set1_data [i][0] <= 32'b0;
					   set1_data [i][1] <= 32'b0;
					   set2_data [i][0] <= 32'b0;
					   set2_data [i][1] <= 32'b0;
					   set1_tag [i] <= 10'b0;
					   set2_tag [i] <= 10'b0;
					   set1_valid [i] <= 1'b0;
					   set2_valid [i] <= 1'b0;
					   cache_lru [i] <= 1'b0;
					end
        end
        else if(Cache_RE) begin
          if(set1_hit) cache_lru[index] = 1'b0;
          else if(set2_hit) cache_lru[index] = 1'b1;
        end
        else if (Cache_WE) begin
          if(cache_lru[index]) begin
            set1_data[index][0] <= CacheWriteData[31:0];
            set1_data[index][1] <= CacheWriteData[63:32];
            set1_tag[index] <= tag;
            set1_valid[index] <= 1'b1;
          end
          else begin
            set2_data[index][0] <= CacheWriteData[31:0];
            set2_data[index][1] <= CacheWriteData[63:32];
            set2_tag[index] <= tag;
            set2_valid[index] <= 1'b1;
          end
        end
    end

endmodule

