`timescale 1ns/1ns

module ARM_TB;

    reg clk = 0;
    reg sram_clk = 1;
    reg rst;
    reg sram_rst;
    reg isForwardingActive;
    wire SRAM_WE_N;
    wire [16:0] SRAM_ADDR;
    wire [31:0] SRAM_DQ;

    ARM CPU(
        .clk(clk),
        .rst(rst),
        .isForwardingActive(isForwardingActive),
        .SRAM_WE_N(SRAM_WE_N),
        .SRAM_ADDR(SRAM_ADDR),
        .SRAM_DQ(SRAM_DQ)
    );
    
    SRAM sram (
        .clk(sram_clk),
        .rst(sram_rst),
        .SRAM_WE_N(SRAM_WE_N),
        .SRAM_ADDR(SRAM_ADDR),
        .SRAM_DQ(SRAM_DQ)
    );

    always #10 clk = ~clk;
    always #20 sram_clk = ~sram_clk;
    
    initial begin
        rst = 1;
        sram_rst = 1;
        isForwardingActive = 1;
        # (30);
        rst = 0;
        sram_rst = 0;
        # (15000);
        //rst = 1;
        //isForwardingActive = 0;
        //# (30);
        //rst = 0;
        //# (15000);
    $stop;
    end
    
endmodule
